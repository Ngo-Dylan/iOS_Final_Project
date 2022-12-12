//
//  CardListView.swift
//  RemindYou
//
//  Created by Dylan Ngo on 12/11/22.
//

import SwiftUI

struct CardListView: View {
    @EnvironmentObject var cardsViewModel: CardsViewModel
    @State private var showingAddCardView = false
    
    
    var body: some View {
        List {
            ForEach(cardsViewModel.cards) { card in
                ZStack {
                    NavigationLink {
                        CardDetails(card: card)
                    } label: {
                    }
                    .buttonStyle(PlainButtonStyle())
                    .opacity(0)

                    CardView(card: card)
                }
            }
            .onDelete(perform: cardsViewModel.deleteCard)
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Day Count")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAddCardView = true
                } label: {
                    Image(systemName: "plus")
                        .font(.headline)
                }
            }
        }
        .sheet(isPresented: $showingAddCardView) {
            AddEventView()
        }
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        CardListView()
            .environmentObject(CardsViewModel())
    }
}
