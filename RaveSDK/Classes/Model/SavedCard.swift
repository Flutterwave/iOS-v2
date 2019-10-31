//
//  SavedCard.swift
//  GetBarter
//
//  Created by Olusegun Solaja on 10/10/2018.
//  Copyright © 2018 Olusegun Solaja. All rights reserved.
//

import Foundation
struct SavedCard: Codable {
    var device:String?
    var mobileNumber:String?
    var email:String?
    var cardHash:String?
    var card:Card?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        device = try values.decodeIfPresent(String?.self, forKey: .device) ?? nil
        mobileNumber = try values.decodeIfPresent(String?.self, forKey: .mobileNumber) ?? nil
        email = try values.decodeIfPresent(String?.self, forKey: .email) ?? nil
        cardHash = try values.decodeIfPresent(String?.self, forKey: .cardHash) ?? nil
        card = try values.decodeIfPresent(Card?.self, forKey: .card) ?? nil
    }
}

extension SavedCard{
    enum CodingKeys:String,CodingKey{
        case device = "device"
        case mobileNumber = "mobile_number"
        case email = "email"
        case cardHash = "card_hash"
        case card = "card"
    }
}


struct Card: Codable {
    var maskedPan:String?
    var cardBrand:String?
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        maskedPan = try values.decodeIfPresent(String?.self, forKey: .maskedPan) ?? nil
        cardBrand = try values.decodeIfPresent(String?.self, forKey: .cardBrand) ?? nil
    }
}

extension Card{
    enum CodingKeys:String,CodingKey{
        case maskedPan = "masked_pan"
        case cardBrand = "card_brand"
    }
}


struct SavedCardResponse: Codable {
    var status:String?
    var message:String?
    var cards:[SavedCard]?
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String?.self, forKey: .status) ?? nil
        message = try values.decodeIfPresent(String?.self, forKey: .message) ?? nil
        cards = try values.decodeIfPresent([SavedCard]?.self, forKey: .cards) ?? nil
    }
}
extension SavedCardResponse{
    enum CodingKeys:String,CodingKey{
        case status
        case message
        case cards = "data"
    }
}
