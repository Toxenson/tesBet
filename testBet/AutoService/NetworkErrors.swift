//
//  NetworkErrors.swift
//  testBet
//
//  Created by Тоха on 13.06.2022.
//

import UIKit

enum NetworkErrors: Error {
    case emptyCity
    case httpError(NetworkError)
    case emptyCoordinates
    case failedUrl
    case cantConvertResponse
    case unsafeData
}

struct NetworkError: Codable {
    let cod: Int
    let message: String
    
    static func parseJson(from json: Data) -> NetworkError? {
        debugPrint("also parsing json")
        do {
            debugPrint("json parsed")
            return try JSONDecoder().decode(NetworkError.self, from: json)
        } catch {
            return nil
        }
    }
}
