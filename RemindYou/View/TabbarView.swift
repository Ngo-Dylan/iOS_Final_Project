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
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            Todo()
                .tabItem {
                    Label("Todo", systemImage: "list.bullet")
                }
            DayCount()
                .tabItem() {
                    Label("Day Count", systemImage: "calendar.day.timeline.trailing")
                }
            SettingsView()
                .tabItem() {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
