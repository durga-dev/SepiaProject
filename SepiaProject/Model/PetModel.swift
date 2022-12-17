//
//  PetModel.swift
//  sepia
//
//  Created by User on 15/12/22.
//

import Foundation

public struct PetModel: Codable {
    let pets: [Pet]?
}

public struct Pet: Codable {
    let imageUrl: String?
    let title: String?
    let contentUrl: String?
    let dateAdded: String?
}
