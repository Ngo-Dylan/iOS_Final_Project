//
//  Calendar_WeekBar.swift
//  RemindYou
//
//  Created by Dylan Ngo on 12/4/22.
//

import SwiftUI

struct Calendar_WeekBar: View {
    @EnvironmentObject var CalendarManager : CalendarManager

    var body: some View {
        HStack {
            ForEach(self.weeks(),id:\.self) { week in
                HStack {
                    Spacer()
                    Text(week)
                        .bold()
                        .lineLimit(1)
                        .foregroundColor(.black)
                    Spacer()
                }
            }
        }
    }

    func weeks() -> [String] {
        return CalendarManager.calendar.veryShortWeekdaySymbols
    }
}

struct Calendar_WeekBar_Previews: PreviewProvider {
    static var previews: some View {
        Calendar_WeekBar().environmentObject(CalendarManager())
    }
}
