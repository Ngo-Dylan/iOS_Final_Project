//
//  TabbarView.swift
//  RemindYou
//
//  Created by Dylan Ngo on 11/29/22.
//

import SwiftUI

struct TabbarView: View {
    var body: some View {
        TabView {
            Calendar()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            Todo()
                .tabItem {
                    Label("Todo", systemImage: "list.bullet")
                }
        }
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
