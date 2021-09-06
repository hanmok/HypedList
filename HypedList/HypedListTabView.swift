//
//  HypedListTabView.swift
//  HypedList
//
//  Created by Mac mini on 2021/08/28.
//

import SwiftUI

struct HypedListTabView: View {
    var body: some View {
        TabView {
            NavigationView {
                UpcomingView()
            }
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Upcoming")
                }
            NavigationView {
                DiscoverView()
            }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Discover")
                }
            NavigationView {
                PastView()
            }
                .tabItem {
                    Image(systemName: "gobackward")
                    Text("Past")
                }
            
        }.onAppear() {
            print("TabView appeared")
        }
    }

}

struct HypedListTabView_Previews: PreviewProvider {
    static var previews: some View {
        HypedListTabView()
    }
}

