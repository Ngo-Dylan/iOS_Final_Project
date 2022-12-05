//
//  Calendar.swift
//  RemindYou
//
//  Created by Dylan Ngo on 11/29/22.
//

import SwiftUI
import Combine

class CalendarManager : ObservableObject {
    
    let didChangeSelectedDate = PassthroughSubject<Date,Never>()
    
    @Published var calendar : Calendar = .current
    @Published var selectedDate : Date = Date() {
        didSet {
            didChangeSelectedDate.send(selectedDate)
        }
    }
    @Published var selectedDates : [Date] = []
    @Published var pageManager = PageManager()
    @Published var date : Date = Date()
    
    var anyCancellable: AnyCancellable? = nil
    
    init() {
        anyCancellable = pageManager.objectWillChange.sink(receiveValue: { value in
            self.objectWillChange.send()
        })
    }
}

struct CalendarView: View {
    @State private var maxGlass: Int = 16
    var calendarObj = CalendarManager()

    var body: some View {
        VStack {
            Spacer()
                .frame(height: 100)
            Text("Calendar")
                .font(.system(size: 40))
                .foregroundColor(.white)
                .bold()
            ZStack(alignment: .top){
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.red.opacity(0.5), lineWidth: 2)
                    .frame(height: 480)
                    .padding()
                VStack{
                    Calendar_Base()
                        .padding(.horizontal)
                        .padding(.vertical)
                        .environmentObject(calendarObj)
//                    VStack{
//                        Spacer()
//                            .frame(height: 30)
//                        HStack{
//                            Text("Check calendar")
//                                .bold()
//                                .foregroundColor(Color.white)
//                                .font(.system(size: 17))
//                                .padding(.horizontal)
//                            Spacer()
//                        }
//                    }.padding(.horizontal, 30)
//                        .frame(alignment: .topLeading)
                }
            }
            Spacer()
        }
        .background(.white.opacity(0.8))
            .edgesIgnoringSafeArea(.all)
            .padding(.bottom, 5)
    }
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
