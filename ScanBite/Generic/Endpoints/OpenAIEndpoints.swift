//
//  OpenAIEndpoints.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 19/04/2025.
//


import Foundation

enum OpenAIEndpoints {
    
    case personalizedPlanView(prompt: String)
    case scanMenu(prompt: String)
    case scanFood(prompt: String, image: String)
    
}
extension OpenAIEndpoints : Endpoint {
    
    
    var path: String {
        
        switch self {
            
        case .personalizedPlanView :
            return "api.openai.com/v1/chat/completions"
            
        case .scanMenu:
            return "api.openai.com/v1/chat/completions"
           
        case .scanFood:
            return "api.openai.com/v1/chat/completions"
            

        }
    }
    
    var method: RequestMethod {
        
        switch self {
            
        case .personalizedPlanView:
            return .post
            
        case .scanMenu:
            return .post
            
        case .scanFood:
            return .post
            
        }
    }
    
    var header: [String: String]? {
        
        switch self {
            
        case .personalizedPlanView:
            
            return  [
                "Authorization": "Bearer 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",
                "Content-Type": "application/json"
            ]
            
        case .scanMenu:
            
            return  [
                "Authorization": "Bearer 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",
                "Content-Type": "application/json"
            ]
            
        case .scanFood:
            
            return  [
                "Authorization": "Bearer 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",
                "Content-Type": "application/json"
            ]
        }
    }
    
    var body: [String : Any?]? {
        switch self {
            
            
        case .personalizedPlanView(let prompt):
            
            return [
                "model": "gpt-4o",
                "messages": [
                    ["role": "system", "content": "You are a nutritionist."],
                    ["role": "user", "content": prompt]
                ],
                "temperature": 0.0
            ]
            
        case .scanMenu(let prompt):
            
            return [
                "model": "gpt-4o",
                "messages": [
                    ["role": "system", "content": "You are a highly advanced nutritional assistant specializing in food analysis. Your task is to extract all meal data from the provided unstructured text, return JSON with nutrition analysis and alternatives based on the user's dietary goal."],
                    ["role": "user", "content": prompt]
                ],
                "temperature": 0.0
            ]
            
        case .scanFood(let prompt, let image):
            
           return [
                "model": "gpt-4o",
                "messages": [
                    ["role": "system", "content": "You are a highly advanced nutritional assistant specializing in food analysis. Your task is to extract all meal data from the provided unstructured text, return JSON with nutrition analysis and alternatives based on the user's dietary goal."],
                    ["role": "user", "content": prompt],
                    [
                        "role": "user",
                        "content": [
                            [
                                "type": "image_url",
                                "image_url": [
                                    "url": "data:image/jpeg;base64,\(image)"
                                ]
                            ]
                        ]
                    ]
                ],
                "temperature": 0.0
            ]
            
        }
        
    }
    
    
}

