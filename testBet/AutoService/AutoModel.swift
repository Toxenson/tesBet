//
//  AutoModel.swift
//  testBet
//
//  Created by Тоха on 13.06.2022.
//

import Foundation

protocol WeatherModelProtocol {
    
}

//MARK: - Autos
struct Cars: Codable {
    let result: Int
    let data: [Car]
    
    static func parseJson(from json: Data) -> Cars? {
        debugPrint("also parsing json")
        do {
            debugPrint("json parsed")
            return try JSONDecoder().decode(Cars.self, from: json)
        } catch {
            debugPrint("wrong autos")
            return nil
        }
    }
}
struct Car: Codable {
    let brandID, modelName, releaseDate: String

    enum CodingKeys: String, CodingKey {
        case brandID = "brand_id"
        case modelName, releaseDate
    }
}

//MARK: - Brand
struct Brands: Codable {
    let result: Int
    let data: [Brand]
    
    static func parseJson(from json: Data) -> Brands? {
        debugPrint("also parsing json")
        do {
            debugPrint("json parsed")
            return try JSONDecoder().decode(Brands.self, from: json)
        } catch {
            debugPrint("wrong brands")
            return nil
        }
    }
}
struct Brand: Codable {
    let id, brandName: String
    let founderNames: [String]
    let foundationDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case brandName = "brand_name"
        case founderNames = "founder_names"
        case foundationDate
    }
}

struct MyBrand {
    let id: String
    let brandName: String
    let founderNames: [String]
    let foundationDate: String
    let cars: [Car]
}

