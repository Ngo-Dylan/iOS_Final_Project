//
//  CardDetails.swift
//  RemindYou
//
//  Created by Dylan Ngo on 12/11/22.
//

import SwiftUI

private struct DateBoxStyle: GroupBoxStyle {
    var cardColor: Color

    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 10) {
            configuration.label
            configuration.content
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(cardColor.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct CardDetails: View {
    @EnvironmentObject var cardsViewModel: CardsViewModel
    @State private var showingAddCardView = false
    var card: Card
    private var ColumnGrid = Array(repeating: GridItem(.flexible()), count: 2)

    var body: some View {
        ScrollView {
            Spacer()
                .frame(height: 40)
                Text(card.date.formatted(date: .numeric, time: .shortened))
                    .font(.title)
                    .fontWeight(.bold)

            Spacer()
                .frame(height: 80)

            LazyVGrid(columns: ColumnGrid) {
                GroupBox("Years") {
                    Text("\(cardsViewModel.getYear(date: card.date))")
                        .foregroundColor(.red)
                }

                GroupBox("Months") {
                    Text("\(cardsViewModel.getMonth(date: card.date))")
                        .foregroundColor(.red)
                }

                GroupBox("Days") {
                    Text("\(cardsViewModel.getDay(date: card.date))")
                        .foregroundColor(.red)
                }

                GroupBox("Hours") {
                    Text("\(cardsViewModel.getHour(date: card.date))")
                        .foregroundColor(.red)
                }
            }
            .groupBoxStyle(DateBoxStyle(cardColor: card.color))
            .font(.body.bold())
            

            Spacer()
        }
        .padding()
        .navigationTitle(card.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAddCardView = true
                } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.headline)
                }
            }
        }
        .sheet(isPresented: $showingAddCardView) {
            AddEventView(id: card.id, title: card.title, color: card.color, date: card.date)
        }
    }
    
    init(card: Card) {
        self.card = card
    }
}

struct CardDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CardDetails(card: Card(title: "Birthday", date: .now, color: .blue))
                .environmentObject(CardsViewModel())
        }
    }
}
