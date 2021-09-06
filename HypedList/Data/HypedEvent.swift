//
//  HypedEvent.swift
//  HypedList
//
//  Created by Mac mini on 2021/08/29.
//

import Foundation
import SwiftUI
import SwiftDate
import UIColorHexSwift

// object that is obervable, identifiable,
//ObservableObject will provide you with a binding to any contained property automatically via the $-prefix syntax:
class HypedEvent: ObservableObject, Identifiable, Codable { // similar to viewModel ? ?
    
    var id = UUID().uuidString // universally unique id. 
    
    var date = Date()
    var title = ""
    var url = ""
    var color = Color.purple // color is  not encodable by default.
    
    @Published var imageData : Data?
    
    enum CodingKeys: String, CodingKey {// it has to be named CodingKeys
        case id
        case date
        case title
        case url
        case color
        case imageData
    }
    
    // encode
    // to make this encoable Function,
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: CodingKeys.id)
        try container.encode(date, forKey: CodingKeys.date)
        try container.encode(title, forKey: CodingKeys.title)
        try container.encode(url, forKey: CodingKeys.url)
        // make color into hexString, then encode.
        try container.encode(UIColor(color).hexString(), forKey: CodingKeys.color)
        try container.encode(imageData, forKey: CodingKeys.imageData)
       
    }
    
    // decode
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: .id)
        date = try values.decode(Date.self, forKey: .date)
        title = try values.decode(String.self, forKey: .title)
        url = try values.decode(String.self, forKey: .url)
        
        let colorHex = try values.decode(String.self, forKey: .color)
        color = Color(UIColor(colorHex))
        
        imageData = try? values.decode(Data.self, forKey: .imageData)
    }
    
    init() {
        
    }
    
    func image() -> Image? {
        if let data  = imageData {
            if let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            }
        }
        return nil
    }
    
    func dateAsString() -> String {
        let formatter = DateFormatter()

        formatter.dateFormat = date.compare(.isThisYear) ? "MMM d" : "MMM d yyyy"
        return formatter.string(from: date)
    }
    
    func timeFromNow() -> String {
        return date.toRelative()
    }
    
    func validURL() -> URL?{
        return URL(string: url)
    }
}




//MARK: - Dummy Datas


// computed property w
var testHypedEvent1: HypedEvent {
    let hypedEvent = HypedEvent()
    
    if let image = UIImage(named: "wwdc") {
        if let data = image.pngData() {
            hypedEvent.imageData = data
        }
    }
    
    hypedEvent.title = "WWDC 2021"
    hypedEvent.color = .green
    hypedEvent.date = Date() + 4.days
    hypedEvent.url = "www.google.com"
    
//    hypedEvent.imageData =
    return hypedEvent
}

var testHypedEvent2: HypedEvent {
    let hypedEvent = HypedEvent()
    
    hypedEvent.title = "Family and Friends Trip to Jackson and then Arizona"
    hypedEvent.color = .blue
    hypedEvent.date = Date() + 2.hours + 23.minutes + 1.days + 3.years
//    hypedEvent.url = "www.google.com"

    return hypedEvent
}
