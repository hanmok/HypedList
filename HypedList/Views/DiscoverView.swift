//
//  DiscoverView.swift
//  HypedList
//
//  Created by 이한목 on 2021/09/06.
//

import SwiftUI

struct DiscoverView: View {
    
    @ObservedObject var data = DataController.shared
    
    
    var body: some View {
        HypedEventListView(hypedEvents: data.discoverHypedEvents.sorted {
            $0.date < $1.date
        }, noEventsTEXT: "Loading some awesome stuff for ya!", isDiscover: true)
        .navigationTitle("Discover")
        .navigationBarItems(trailing:
                                Button(action:{
                                    data.getDiscoverEvents()
                                }) {
                                    Image(systemName: "arrow.clockwise")
                                        .font(.title)
                                }
        )
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
