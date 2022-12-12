//
//  CardView.swift
//  RemindYou
//
//  Created by Dylan Ngo on 12/11/22.
//

import SwiftUI

struct CardStyle: GroupBoxStyle {
    var cardColor: Color

    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 15) {
            configuration.label
            configuration.content
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(cardColor.opacity(0.16))
    }
}

struct CardView: View {
    @EnvironmentObject var cardsViewModel: CardsViewModel
    var card: Card

    var body: some View {
        GroupBox {
            Text(cardsViewModel.dateShortFormat(card: card))
        } label: {
            Text("\(card.title)")
                .font(.title2)
                .fontWeight(.bold)
        }
        .groupBoxStyle(CardStyle(cardColor: card.color))
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(title: "Birthday", date: .now, color: .blue))
            .previewLayout(.sizeThatFits)
            .environmentObject(CardsViewModel())
    }
}
