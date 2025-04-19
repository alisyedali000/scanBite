//
//  Endpoint.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 19/04/2025.
//

import Foundation

let api_key = "api_c2d0e5808a93a9e98c1928a2980ec0c2b74184bfcffcd7a6eccec89b"
let request_ts = "1223344444"
let hash_key = "9dec12c953b81c8290f3d981892ea3337523a3a1688770645b2e843fa3219b10"

func getParamsFromCodable<T:Codable>(object:T) -> [String : Any]? {
    
    var param : [String : Any] = [:]
    
    let jsonEncoder = JSONEncoder()
    if let jsonData = try? jsonEncoder.encode(object){
        let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)
        
        if let json = jsonString {
            param =  convertJsonToDictionary(text: json) ?? [:]
        }
        
    }
    
    return param
}
func convertJsonToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: Any?]? { get }
    
    var queryItems: [URLQueryItem]? { get }
}

extension Endpoint {
    
    var body: [String: Any?]? {
        return nil
    }
    
    var scheme: String {
        return AppUrl.SCHEME
    }
    
    var host: String {
        return AppUrl.BASEURL
    }
    
    var header: [String: String]? {
        
        
        
        
        return ["Content-Type": "application/json",
                "keyhich": "hich0101"]
        
        
    }
    
    var queryItems:[URLQueryItem]? {
        nil
    }
    
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized(reason:String?)
    case sessionExpried
    case unexpectedStatusCode
    case custom(message:String)
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized (let reason):
            return reason ?? "Session expired"
            
        case .custom(let message):
            return message
        default:
            return "Unknown error"
        }
    }
}

protocol NetworkManagerService {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}
extension NetworkManagerService {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError> {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
//        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems
        
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
//        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        debugPrint("⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️")
        debugPrint(url)
        
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        request.timeoutInterval = 180
        if let body = endpoint.body {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
                request.httpBody = jsonData
                debugPrint("params \(String(decoding: jsonData, as: UTF8.self))")
            } catch {
                return .failure(.unknown)
            }
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            
            debugPrint(String(data: data, encoding: String.Encoding.utf8) ?? "")
            
            switch response.statusCode {
            case 200...299:
                do {
                    let decodedResponse = try JSONDecoder().decode(responseModel, from: data)
                    return .success(decodedResponse)
                    
                } catch let error {
                    debugPrint(error)
                    debugPrint("❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌")
                    return .failure(.decode)
                }
                
            case 401:
                let error = try parseJSON(from: data)
                debugPrint("❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌")
                debugPrint(error)
                DispatchQueue.main.async {
                    if error.message == "Unauthenticated."{
                        debugPrint("API Failure!")
                    }
                }
                return .failure(.unauthorized(reason: error.message))
                
            default:
                debugPrint("❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌")
                let response = try parseJSON(from: data)
                return .failure(.unauthorized(reason: response.message))
            }
        } catch let error {
            debugPrint("❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌")
            return .failure(.unauthorized(reason: error.localizedDescription))
        }
    }
    
    private func parseJSON(from data: Data) throws -> GenericResponse {
        do {
            let decode = try JSONDecoder().decode(GenericResponse.self, from: data)
            debugPrint(decode)
            return decode
            /// force logout here if needed
        } catch let error {
            debugPrint(error)
            debugPrint("❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌")
        }
        return GenericResponse()
    }
}
