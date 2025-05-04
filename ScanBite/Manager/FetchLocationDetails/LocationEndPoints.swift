//
//  LocationEndPoints.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 02/05/2025.
//


import Foundation

enum LocationEndPoints {
    
    case getNearbyRestaurants(location: String)
    
}
extension LocationEndPoints : Endpoint {
    
    
    var path: String {
        
        switch self {
            
        case .getNearbyRestaurants:
            return "maps.googleapis.com/maps/api/place/nearbysearch/json"

        }
    }
    
    var method: RequestMethod {
        
        switch self {
            
        case .getNearbyRestaurants:
            return .post

            
        }
    }
    
    var queryItems: [URLQueryItem]? {
            switch self {
            case .getNearbyRestaurants(let location):

                return [
                    URLQueryItem(name: "location", value: "\(location)"),
                    URLQueryItem(name: "radius", value: "500"),
                    URLQueryItem(name: "type", value: "restaurant"),
                    URLQueryItem(name: "key", value: "\(googleAPIKey)"),
                ]

            }
        }
    
    
}


