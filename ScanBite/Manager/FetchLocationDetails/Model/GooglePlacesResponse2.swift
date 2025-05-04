//
//  GooglePlacesResponse.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 02/05/2025.
//


//struct GooglePlacesResponse: Codable {
//    let results: [Place]  // Renamed from `Restaurant` to `Place`
//    let status: String
//}
//
//// MARK: - Place Model (Previously `Restaurant`)
//struct Place: Codable {
//    let name: String
//    let placeID: String
//    let rating: Double?
//    let userRatingsTotal: Int?
//    let vicinity: String?
//    let openingHours: OpeningHours?
//    let photos: [Photo]?
//    let plusCode: PlusCode?
//    let types: [String]?
//    let icon: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case name, rating, vicinity, photos, types, icon
//        case placeID = "place_id"
//        case userRatingsTotal = "user_ratings_total"
//        case openingHours = "opening_hours"
//        case plusCode = "plus_code"
//    }
//    
//}
//
//// MARK: - Opening Hours
//struct OpeningHours: Codable {
//    let openNow: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case openNow = "open_now"
//    }
//}
//
//// MARK: - Photo
//struct Photo: Codable {
//    let height: Int
//    let width: Int
//    let photoReference: String
//
//    enum CodingKeys: String, CodingKey {
//        case height, width
//        case photoReference = "photo_reference"
//    }
//}
//
//// MARK: - Plus Code
//struct PlusCode: Codable {
//    let compoundCode: String
//    let globalCode: String
//
//    enum CodingKeys: String, CodingKey {
//        case compoundCode = "compound_code"
//        case globalCode = "global_code"
//    }
//}
