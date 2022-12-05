//
//  Calendar_DateCollection.swift
//  RemindYou
//
//  Created by Dylan Ngo on 12/4/22.
//

import SwiftUI

struct HolderDate : Hashable {
    let date : Date?
}

struct Calendar_DateCollection: View {
    @EnvironmentObject var obj : CalendarManager
    @State private var state : Calendar_Cell.CellState = .normal

    var body: some View {
        Calendar_Page(pageManager: self.obj.pageManager, views:[self.page()])
            .frame(height: 47 * 7.8)
    }
    
    func page() -> some View {
        VStack {
            VStack {
                ForEach(self.datesArray(),id: \.self) { rows in
                    HStack(spacing:0) {
                        ForEach(rows,id: \.self) { column in
                            HStack {
                                Spacer(minLength: 0)
                                Calendar_Cell(holderDate: column)
                                Spacer(minLength: 0)
                            }
                        }
                    }
                    Divider()
                }
            }.font(.system(size: 15))
            Spacer(minLength: 0)
        } .background(.white)
    }
    
    // Combine row and column
    func datesArray() -> [[HolderDate]] {
        var rowArray : [[HolderDate]] = []
        let columns = numberOfColumns()
        let rows = numberOfRows()
        let days = self.obj.date.allDays()
        let placeholder = HolderDate(date: nil)
        let offset = dayOffset()
        
        for row in 0..<rows {
            var columnArray : [HolderDate] = []
            for column in 0..<columns {
                let index = row * columns + column
                if index < offset || days.count <= (index - offset) {
                    columnArray.append(placeholder)
                } else {
                    let d = days[index - offset]
                    columnArray.append(HolderDate(date: d))
                }
            }
            rowArray.append(columnArray)
        }
        return rowArray
    }
    
    // Rows in a month
    func numberOfRows() -> Int {
        let actualDays = obj.date.numberOfDays()
        let offset = dayOffset()
        let days = actualDays + offset
        let columns = numberOfColumns()
        let number = days % columns
        if number == 0 {
            return days / columns
        } else {
            return days / columns + 1
        }
    }
    
    // Number of columns
    func numberOfColumns() -> Int {
        return 7
    }
    
    func dayOffset() -> Int {
        return obj.date.firstDayOfWeek() - 1
    }
}

struct Calendar_DateCollection_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Calendar_DateCollection()
                .environmentObject(CalendarManager())
        }
    }
}
