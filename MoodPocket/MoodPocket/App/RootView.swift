//
//  RootView.swift
//  MoodPocket
//
//  Created by 이건우
//

import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationStack {
            TabView {
                MainView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                
                ArchiveView()
                    .tabItem {
                        Image(systemName: "archivebox")
                        Text("Archive")
                    }
            }
            .tint(.black)
        }
    }
}

#Preview {
    RootView()
}
