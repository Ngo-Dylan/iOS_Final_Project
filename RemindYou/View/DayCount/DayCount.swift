//
//  DayCount.swift
//  RemindYou
//
//  Created by Dylan Ngo on 12/5/22.
//

import SwiftUI

struct DayCount: View {
    var body: some View {
        NavigationView {
            CardListView()
        }
    }
}

struct DayCount_Previews: PreviewProvider {
    static var previews: some View {
        DayCount()
            .environmentObject(CardsViewModel())
    }
}
