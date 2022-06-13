//
//  AutoService.swift
//  testBet
//
//  Created by Тоха on 13.06.2022.
//

import Foundation

protocol AutoService {
    func getCars(completition: @escaping (Cars?, NetworkErrors?) -> ())
    func getBrands(completition: @escaping (Brands?, NetworkErrors?) -> ())
}

struct AutoServiceImpl: AutoService {
    private let autosURL = "http://www.mocky.io/v2/5db9630530000095005ee272"
    private let brandURL = "http://www.mocky.io/v2/5db959e43000005a005ee206"
    
    func getCars(completition: @escaping (Cars?, NetworkErrors?) -> ()) {
        
        let finalUrl = URL(string: autosURL)
        debugPrint("loading cars")
        guard let finalUrl = finalUrl else {
            completition(nil, .failedUrl)
            return
        }
        performRequest(with: finalUrl) { autos, error in
            completition(autos, error)
        }
    }
    
    func getBrands(completition: @escaping (Brands?, NetworkErrors?) -> ()) {
        let finalUrl = URL(string: brandURL)
        debugPrint("loading brands")
        guard let finalUrl = finalUrl else {
            completition(nil, .failedUrl)
            return
        }
        performRequest(with: finalUrl) { brands, error in
            completition(brands, error)
        }
    }
    
    private func performRequest<T>(with url: URL, completition: @escaping (T?, NetworkErrors?) -> ()) {
        debugPrint("start session")
        let urlRequest = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 30)
        let callbackMainThread: (T?, NetworkErrors?) -> () = { device, error in
            DispatchQueue.main.async {
                completition(device, error)
            }
        }
        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                callbackMainThread(nil, .cantConvertResponse)
                return
            }
            debugPrint("chekin status code")
            switch httpResponse.statusCode {
            case 400:
                callbackMainThread(nil, .emptyCoordinates)
            case 404:
                callbackMainThread(nil, .emptyCity)
            case 200:
                guard let data = data else {
                    callbackMainThread(nil, .unsafeData)
                    return
                }
                print("data is safe")
                switch T.self {
                case is Cars.Type:
                    callbackMainThread(Cars.parseJson(from: data) as? T, nil)
                case is Brands.Type:
                    callbackMainThread(Brands.parseJson(from: data) as? T, nil)
                default:
                    callbackMainThread(nil, .cantConvertResponse)
                }
            default:
                guard let data = data, let networkError = NetworkError.parseJson(from: data) else {
                    callbackMainThread(nil, .unsafeData)
                    return
                }
                callbackMainThread(nil, .httpError(networkError))
            }
        }.resume()
        debugPrint("session resumed")
        }
}
