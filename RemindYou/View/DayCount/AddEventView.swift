//
//  AddEventView.swift
//  RemindYou
//
//  Created by Dylan Ngo on 12/11/22.
//

import SwiftUI

struct AddEventView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var cardsViewModel: CardsViewModel
    @State private var isEditMode = false
    @State private var id = UUID()
    @State private var title: String = ""
    @State private var color: Color = .blue
    @State private var date: Date = .now
    @State private var selectedColorIndex = 7
    static let colors: [Color] = [.red, .orange, .yellow, .green, .mint, .teal, .cyan, .blue, .indigo, .pink, .purple, .brown]

    private var ColumnGrid = Array(repeating: GridItem(.flexible()), count: 6)

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
                        .font(.subheadline.bold())
                }

                Section {
                    DatePicker("Date", selection: $date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .frame(height: 300)
                }

                Section {
                    LazyVGrid(columns: ColumnGrid) {
                        ForEach(0 ..< Self.colors.count, id: \.self) { index in
                            Circle()
                                .fill(Self.colors[index])
                                .frame(width: 30, height: 30)
                                .padding(6)
                                .overlay(content: {
                                    if index == selectedColorIndex {
                                        Circle()
                                            .strokeBorder(lineWidth: 3)
                                            .foregroundColor(.gray.opacity(0.30))
                                    }
                                })
                                .onTapGesture {
                                    selectedColorIndex = index
                                    color = Self.colors[index]
                                }
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .font(.headline)
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if isEditMode {
                            cardsViewModel.editCard(id: id, title: title, date: date, color: color)
                        } else {
                            cardsViewModel.addCard(title: title, date: date, color: color)
                        }

                        dismiss()
                    } label: {
                        Text("Done")
                            .font(.headline)
                    }

                }
            }
        }
    }
    init() { }

    init(id: UUID, title: String, color: Color, date: Date) {
        _id = State(initialValue: id)
        _title = State(initialValue: title)
        _color = State(initialValue: color)
        _date = State(initialValue: date)
        _selectedColorIndex = State(initialValue: Self.colors.firstIndex(of: color) ?? 7)
        _isEditMode = State(initialValue: true)
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView()
            .environmentObject(CardsViewModel())
    }
}
