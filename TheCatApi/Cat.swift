//
//  Cat.swift
//  TheCatApi
//
//  Created by Oscar David Myerston Vega on 8/03/23.
//

import Foundation


struct Cat: Decodable, Identifiable {

    let id : String
    let breedName: String
    let origin: String
    let affectionLevel: Int
    let intelligence: Int
    let imageUrl: String?

    enum CodingKeys: String, CodingKey{
        case id
        case breedName = "name"
        case origin
        case affectionLevel = "affection_level"
        case intelligence
        case imageUrl = "reference_image_id"
    }

}
