//
//  RestaurantsModel.swift
//  UberEatsLike
//
//  Created by user on 2021/09/04.
//

import Foundation

// MARK: - RestaurantJSON
struct RestaurantJSON: Codable {
    let restaurants: [Restaurant]
}

// MARK: - Restaurant
struct Restaurant: Codable {
    let id: Int
    let name: String
    let fee, timeRequired: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name, fee
        case timeRequired = "time_required"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
