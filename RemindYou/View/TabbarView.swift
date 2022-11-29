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
            Todo()
                .tabItem {
                    Label("Todo", systemImage: "list.bullet")
                }
            Calendar()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
        }
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
