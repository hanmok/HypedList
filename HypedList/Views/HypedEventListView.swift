//
//  HypedEventListView.swift
//  HypedList
//
//  Created by 이한목 on 2021/09/06.
//

import SwiftUI

struct HypedEventListView: View {
    
    var hypedEvents: [HypedEvent]
    var noEventsTEXT: String
    var isDiscover = false
    
    var body: some View {
        ScrollView {
            VStack {
                if hypedEvents.count == 0 {
                    Text(noEventsTEXT)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.top, 50)
                        .padding(.horizontal, 20)
                } else {
                    ForEach(hypedEvents) { hypedEvent in
                        NavigationLink(
                            destination:
                        HypedEventDetailView(hypedEvent: hypedEvent, isDiscover: isDiscover)
                        ){
                            HypedEventTileView(hypedEvent: hypedEvent)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
}

struct HypedEventListView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            HypedEventListView(hypedEvents: [testHypedEvent1, testHypedEvent2], noEventsTEXT: "Nothing here :(")
            
            HypedEventListView(hypedEvents: [], noEventsTEXT: "Nothing here :(")
        }
        

    }
}
