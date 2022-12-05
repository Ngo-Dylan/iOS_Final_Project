//
//  Calendar_Cell.swift
//  RemindYou
//
//  Created by Dylan Ngo on 12/4/22.
//

import SwiftUI

struct Calendar_Cell: View {
    
    @EnvironmentObject var obj : CalendarManager
    
    var holderDate : HolderDate
    
    @State var state : CellState = .normal
    
    enum CellState {
        case normal
        case selected
        case current
        case disabled
        case placeholder
        
        func stateBackColor() -> Color {
            switch self {
            case .normal:
                return .white
            case .selected:
                return .red.opacity(0.9)
            case .current:
                return .yellow.opacity(0.8)
            case .disabled:
                return .white
            case .placeholder:
                return .clear
            }
        }
        
        func stateTextColor() -> Color {
            switch self {
            case .normal:
                return .black
            case .selected:
                return .white
            case .current:
                return .white
            case .disabled:
                return .gray
            case .placeholder:
                return .clear
            }
        }
    }

    var body: some View {
        Button(action: {
            self.buttonTap()
        }) {
            Text(self.day())
        }
        .disabled(holderDate.date == nil || isFuture())
        .frame(width: 44, height: 44)
        .foregroundColor(state.stateTextColor())
        .background(state.stateBackColor())
        .clipShape(Circle())
        .onAppear {
            self.stateChanged(animated: false)
        }
        .onReceive(obj.didChangeSelectedDate) { value in
            self.stateChanged()
        }
    }
    
    func stateChanged(animated : Bool = true) {
        if let _ = holderDate.date {
            let change =  {
                if self.isFuture() {
                    self.state = .disabled
                } else if self.isSelected() {
                    self.state = .selected
                } else if self.isToday() {
                    self.state = .current
                } else {
                    self.state = .normal
                }
            }
            if animated {
                withAnimation {
                    change()
                }
            } else {
                change()
            }
        } else {
            self.state = .placeholder
        }
    }
    
    func buttonTap() {
        if let date = self.holderDate.date {
            withAnimation(.spring()) {
                if self.isSelected() {
                    if isToday() {
                        self.state = .current
                    } else {
                        self.state = .normal
                    }
                    self.obj.selectedDate = Date()
                } else {
                    self.obj.selectedDate = date
                }
            }
        }
    }
    
    func day() -> String {
        if let date = holderDate.date {
            let components = obj.calendar.dateComponents([.day], from: date)
            return "\(components.day!)"
        }
        return ""
    }
    
    func isToday() -> Bool {
        if let date = holderDate.date {
            return date.isToday()
        }
        return false
    }
    
    func isFuture() -> Bool {
        if let date = holderDate.date {
            return date.isFuture()
        }
        return false
    }
    
    func isSelected() -> Bool {
        if let date = holderDate.date {
            let selected = obj.selectedDate
            return date.isSameDay(date: selected)
        }
        return false
    }
}
