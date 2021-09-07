//
//  UpcomingView.swift
//  HypedList
//
//  Created by Mac mini on 2021/08/29.
//

import SwiftUI

struct UpcomingView: View {
    
    @State var showingCreateView = false
    
//    var hypedEvents: [HypedEvent] = [testHypedEvent1, testHypedEvent2, testHypedEvent2]
//    var hypedEvents : [HypedEvent] = []
    
    @ObservedObject var data = DataController.shared
    
    var body: some View {
        
        HypedEventListView(hypedEvents: data.upcomingHypedEvents, noEventsTEXT: "Nothing to look forward to \n Create an event or check out the Discover tab! ")
            .navigationTitle("Upcoming")
            .navigationBarItems(trailing:
                                    Button(action:{
                                        showingCreateView = true
                                    }) {
                                        Image(systemName: "calendar.badge.plus")
                                            .font(.title)
                                    }.sheet(isPresented: $showingCreateView, content: {
                                        CreateHypedEventView()
                                    })
            ).onAppear(){
                print("hypedEvents: \(data.upcomingHypedEvents)")
            }
    }
}

struct UpcomingView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingView()
        Group {
//            NavigationView {
//                UpcomingView(hypedEvents: [testHypedEvent1, testHypedEvent2, testHypedEvent2])
//            }
//            NavigationView {
//                UpcomingView(hypedEvents: [])
//            }
        }
    }
}
