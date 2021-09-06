//
//  PastView.swift
//  HypedList
//
//  Created by 이한목 on 2021/09/06.
//

import SwiftUI

struct PastView: View {
    
    @ObservedObject var data = DataController.shared
    
    
    var body: some View {
        HypedEventListView(hypedEvents: data.pastHypedEvents, noEventsTEXT: "No events have passed yet, you should add some more things! ")
            .navigationTitle("Past")

    }
}

struct PastView_Previews: PreviewProvider {
    static var previews: some View {
        PastView()
    }
}
