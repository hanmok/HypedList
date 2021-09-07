//
//  DataController.swift
//  HypedList
//
//  Created by 이한목 on 2021/08/31.
//

import Foundation
import SwiftDate
import UIColorHexSwift
import UIKit
import SwiftUI

class DataController: ObservableObject {
    // whenever change happens with this array, it changes itself
    @Published var hypedEvents: [HypedEvent] = []
    @Published var discoverHypedEvents: [HypedEvent] = []
    
    var upcomingHypedEvents: [HypedEvent] {

            return hypedEvents.filter{ $0.date > Date().dateAt(.startOfDay)}.sorted {
                $0.date < $1.date
            }
//        return hypedEvents
    }
    
    var pastHypedEvents: [HypedEvent] {
        return hypedEvents.filter { $0.date < Date().dateAt(.startOfDay)}.sorted {
            $0.date > $1.date
        }
    }
    
    func deleteHypedEvent(hypedEvent: HypedEvent) {
        if let index = hypedEvents.firstIndex(where: { loopingHypedEvent -> Bool in
            return hypedEvent.id == loopingHypedEvent.id
        }) {
            hypedEvents.remove(at: index)
        }
        saveData()
    }

    func addFromDiscover(hypedEvent: HypedEvent) {
        hypedEvents.append(hypedEvent)
        hypedEvent.objectWillChange.send() // send notification that it will change its property.
        saveData()
    }
    
//    var discoverHypedEventsSorted: [HypedEvent] {
//        return discoverHypedEvents
//
//            .sorted {
//            $0.date < $1.date
//        }
//    }

    
    
    static var shared = DataController()
    
    func saveHypedEvent(hypedEvent: HypedEvent) {
        if let index = hypedEvents.firstIndex(where: { loopingHypedEvent -> Bool in
            return hypedEvent.id == loopingHypedEvent.id
        }) {
            hypedEvents[index] = hypedEvent
        } else {
            hypedEvents.append(hypedEvent)
        }
        saveData()
    }
    
    // if we don't specify, everything happens in main thread.
    func saveData() {
        DispatchQueue.global().async {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(self.hypedEvents) {
                UserDefaults.standard.setValue(encoded, forKey: "hypedEvents")
                UserDefaults.standard.synchronize()
            }
        }
    }
 
    func loadData() {
        DispatchQueue.global().async {
            if let data = UserDefaults.standard.data(forKey: "hypedEvents"){
                let decoder = JSONDecoder()
                if let jsonHypedEvents = try? decoder.decode([HypedEvent].self, from: data) {
                    DispatchQueue.main.async {
                        self.hypedEvents = jsonHypedEvents
                    }
                }
            }
        }
    }
    
    func getDiscoverEvents() {
        if let url = URL(string: "https://api.jsonbin.io/b/5f7e1e0565b18913fc5c408c/latest") {
        let request = URLRequest(url: url)
            
//            DispatchQueue.global().async {
                 
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let webData = data {
                    if let json = try? JSONSerialization.jsonObject(with: webData, options: []) as? [[String: String]] {
                        
                        var hypedEventsToAdd: [HypedEvent] = []
                        
                        for jsonHypedEvent in json {
//                            print(jsonHypedEvent)
                            let hypedEvent = HypedEvent()
                            if let id = jsonHypedEvent["id"] {
                                hypedEvent.id = id
                            }
                            
                            if let dateString = jsonHypedEvent["date"] {
                                SwiftDate.defaultRegion = Region.local
                                if let dateInRegion = dateString.toDate() {
                                    hypedEvent.date = dateInRegion.date + 2.years
                                }
                            }
                            
                            if let title = jsonHypedEvent["title"] {
                                hypedEvent.title = title
                            }
                            
                            if let url = jsonHypedEvent["url"] {
                                hypedEvent.url = url
                            }
                            
                            if let colorHex = jsonHypedEvent["color"] {
                                    
                                    hypedEvent.color = Color(UIColor("#" + colorHex))
                            }
                            
                            if let imageURL = jsonHypedEvent["imageURL"] {
                                if let url = URL(string: imageURL) {
                                    if let data = try? Data(contentsOf: url) {
                                        hypedEvent.imageData = data
                                    }
                                }
                            }
                            
                            hypedEventsToAdd.append(hypedEvent)
                            
                            
                        }
                        DispatchQueue.main.async {
                            self.discoverHypedEvents = hypedEventsToAdd
                        }
                        
                    }
                }
            }.resume()
//            }
//        https://api.jsonbin.io/b/5f7e1e0565b18913fc5c408c/latest
//        https://api.jsonbin.io/b/6135ab9f470d332594032449
        }
    }
}
