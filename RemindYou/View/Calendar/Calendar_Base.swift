//
//  Calendar_Base.swift
//  RemindYou
//
//  Created by Dylan Ngo on 12/4/22.
//

import SwiftUI

struct Calendar_Base: View {
    @EnvironmentObject var CalendarManager : CalendarManager
    
    var body: some View {
        VStack {
            Calendar_ToolBar()
            Calendar_WeekBar()
            Calendar_DateCollection()
        }.padding()
    }
}

struct Calendar_Base_Previews: PreviewProvider {
    static var previews: some View {
        Calendar_Base().environmentObject(CalendarManager())
    }
}
