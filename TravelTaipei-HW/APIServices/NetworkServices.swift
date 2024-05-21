//
//  NetworkServices.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/12.
//

import Alamofire
import Foundation

enum APIError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case serverError(message: String?)
    
    case invalidData
    case jsonConversionFailure
    case jsonEncoderFailure
    case parameterEncodingFailed
    case responseValidationFailed
    
    var localizedDescription: String {
        switch self {
        case .badRequest:
            return "Request Failed"
        case .invalidData:
            return "Invalid Data"
        case .jsonConversionFailure:
            return "JSON Conversion Failure"
        case .jsonEncoderFailure:
            return "JSON Encoder Failure"
        case .parameterEncodingFailed:
            return "server parameter is failed"
        case .responseValidationFailed:
            return "server response validation is failed"
        case .unauthorized:
            return "Unauthorized"
        case .forbidden:
            return "Forbidden"
        case .notFound:
            return "Not Found"
        case .serverError(message: let message):
            return "\(String(describing: message))"
        }
    }
}

public class NetworkServices {
    
    func requestGenerator<T: Codable>(route: APIConfiguration, type: T.Type,
                                      completion: @escaping(Result<T, APIError>) -> Void) {
        
        // 在後台線程中執行網路請求操作,可以將 QoS 級別調整
        DispatchQueue.global(qos: .utility).async {
            
            do {
                let urlRequest = try route.asURLRequest()
                debugPrint("UrlRequest: \(urlRequest)")
                AF.request(urlRequest)
                    .validate()
                    .responseDecodable(of: T.self) { response in
                        
                        switch response.result {
                        case .success(let data):
                            debugPrint("requestGenerator Success")
                            completion(.success(data))
                        case .failure(let error):
                            debugPrint("requestGenerator failure")
                            if let afError = error as? AFError {
                                let apiError = self.mapAFErrorToAPIError(afError)
                                completion(.failure(apiError))
                            } else {
                                completion(.failure(.serverError(message: error.localizedDescription)))
                            }
                        }
                    }
            } catch {
                debugPrint("Error creating URL request: \(error)")
                completion(.failure(.serverError(message: error.localizedDescription)))
            }
        }
    }
    
    // Helper function to map AFError to APIError
    private func mapAFErrorToAPIError(_ afError: AFError) -> APIError {
        switch afError {
        case .invalidURL:
            return .badRequest
        case let .responseValidationFailed(reason: reason):
            switch reason {
            case .unacceptableStatusCode(let code):
                if code == 401 {
                    return .unauthorized
                } else if code == 403 {
                    return .forbidden
                } else if code == 404 {
                    return .notFound
                } else {
                    return .responseValidationFailed
                }
            default:
                return .responseValidationFailed
            }
        case .parameterEncodingFailed:
            return .parameterEncodingFailed
        default:
            return .serverError(message: afError.localizedDescription)
        }
    }
}

