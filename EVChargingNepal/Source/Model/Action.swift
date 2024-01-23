//
//  Action.swift
//  EVChargingNepal
//
//  Created by Alin Khatri on 13/08/2023.
//

import Foundation

struct Action: Identifiable {
    let id = UUID()
    let title: String
    let image: String
    let handler: () -> Void
}
