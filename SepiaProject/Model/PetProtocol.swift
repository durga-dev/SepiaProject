//
//  PetProtocol.swift
//  sepia
//
//  Created by User on 15/12/22.
//

import Foundation

public protocol PetProtocol {
    var imageUrl: String? { get }
    var title: String? { get }
    var contentUrl: String? { get }
    var dateAdded: String? { get }
}


public struct PetModelMapper: PetProtocol {
    public var imageUrl: String? {
        pet.imageUrl
    }
    
    public var title: String? {
        pet.title
    }
    
    public var contentUrl: String? {
        pet.contentUrl
    }
    
    public var dateAdded: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        if let dateString = pet.dateAdded,
           let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMMM dd, yyyy hh:mm a"
            return dateFormatter.string(from: date)
        }
        return pet.dateAdded
    }
    
    private let pet: Pet
    
    init(pet: Pet) {
        self.pet = pet
    }
    
}
