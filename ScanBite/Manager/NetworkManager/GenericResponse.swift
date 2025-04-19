//
//  GenericResponse.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 19/04/2025.
//


import Foundation

struct GenericResponse: Codable {
    
    var error : String?
    var message: String?
    var status: String?
    var data: String?

}

struct GenericResponseModel<T: Codable>: Codable {

    var data: T?


}


// MARK: - OpenAI Response Models
struct OpenAIResponse: Codable {
    let choices: [Choice]
}

struct Choice: Codable {
    let message: OpenAIMessage
}

struct OpenAIMessage: Codable {
    let content: String
}
