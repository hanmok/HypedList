//
//  HypedListApp.swift
//  HypedList
//
//  Created by Mac mini on 2021/08/28.
//

import SwiftUI

@main
struct HypedListApp: App {
    var body: some Scene {
        WindowGroup {
            HypedListTabView()
                .onAppear {
                    DataController.shared.loadData()
//                    print("hypedListTabView in on appear ! ")
                    DataController.shared.getDiscoverEvents()
                }
        }
    }
}
