//
//  Card.swift
//  MtgPriceChecker
//
//  Created by Takuya Ando on 2021/06/17.
//

import Foundation

struct CardResponse: Codable {
    let data: [CardData]
}

struct CardData: Codable {
    let name: String?
    let prices: [Prices]
    let image_uris: [Images]
}

struct Prices: Codable {
    let usd: String?
    let usd_foil: String?
}

struct Images: Codable {
    let normal: URL
}
