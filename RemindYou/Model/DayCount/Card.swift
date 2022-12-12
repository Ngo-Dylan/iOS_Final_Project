//
//  Card.swift
//  RemindYou
//
//  Created by Dylan Ngo on 12/11/22.
//

import Foundation
import SwiftUI

struct Card: Hashable, Identifiable, Codable {
    var id = UUID()
    var title: String
    var date: Date
    var color: Color
}
