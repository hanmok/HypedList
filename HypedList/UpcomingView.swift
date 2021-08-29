//
//  UpcomingView.swift
//  HypedList
//
//  Created by Mac mini on 2021/08/29.
//

import SwiftUI

struct UpcomingView: View {
    
    @State var showingCreateView = false
    
    var body: some View {
        Text("This is upcoming View!!")
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
            )
    }
}

struct UpcomingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UpcomingView()
        }
    }
}
