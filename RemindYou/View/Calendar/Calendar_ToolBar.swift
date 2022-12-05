//
//  Calendar_ToolBar.swift
//  RemindYou
//
//  Created by Dylan Ngo on 12/4/22.
//

import SwiftUI

struct Calendar_ToolBar: View {
    @EnvironmentObject var CalendarManager : CalendarManager
    
    var components : DateComponents {
        return CalendarManager.calendar.dateComponents([.year,.month,.day], from: CalendarManager.date)
    }
    
    var year : Int  {
        return components.year!
    }
    
    var month : Int {
        return components.month!
    }
    
    var shortMonthSymbols : String {
        return CalendarManager.calendar.monthSymbols[month - 1]
    }
    
    var yearSymbols : String {
        return "\(year)"
    }
    
    var foreColor : Color = .gray

    var body: some View {
        HStack {
            HStack {
                HStack(spacing: 10){
                    Text("\(shortMonthSymbols)")
                        .bold()
                        .padding()
                        .foregroundColor(Color.red)
                        .font(.system(size: 17, weight: .regular))
                    
                    
                    Text("\(yearSymbols)")
                        .foregroundColor(Color.red)
                        .font(.system(size: 17, weight: .regular))
                        .bold()
                }
            }
            Spacer()
            HStack(spacing:10) {
                Button(action: {
                    self.CalendarManager.date = self.CalendarManager.date.addMonth(by:-1)
                    self.CalendarManager.pageManager.currentPage -= 1
                }) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 12, height: 20, alignment: .center)
                        .padding(12)
                        .foregroundColor(Color.blue)
//                        .background(.gray.opacity(0.6))
                        .clipShape(Circle())
                }
                .frame(width: 50, height: 40)
                Button(action: {
                    self.CalendarManager.date = self.CalendarManager.date.addMonth(by:1)
                    self.CalendarManager.pageManager.currentPage += 1
                }) {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 12, height: 20, alignment: .center)
                        .padding(12)
                        .foregroundColor(Color.blue)
//                        .background(.gray.opacity(0.6))
                        .clipShape(Circle())
                }
                .frame(width: 50, height: 40)
            }
        }.foregroundColor(foreColor)
    }
}

struct Calendar_ToolBar_Previews: PreviewProvider {
    static var previews: some View {
        Calendar_ToolBar().environmentObject(CalendarManager())
    }
}
