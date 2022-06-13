//
//  AutoPresenter.swift
//  testBet
//
//  Created by Тоха on 13.06.2022.
//

import UIKit

protocol BasePresenter: AnyObject {
    func performData()
}

protocol PresenterOutput: AnyObject {
    func setNewData(_ data: [MyBrand])
}


class AutoPresenter: BasePresenter {
    weak var output: PresenterOutput?
    private var brandList: [MyBrand] = [] {
        didSet {
            output?.setNewData(brandList)
        }
    }
    private var carList: [Car] = []
    private let carsDatabase: AutoService = AutoServiceImpl()
    
    func performData() {
        
        carsDatabase.getCars { [unowned self] cars, error in
            if let safeCars = cars {
                carList = safeCars.data
            }
            if let safeError = error {
                errorHandler(safeError)
            }
            carsDatabase.getBrands { [unowned self] brands, error in
                if let safeBrands = brands {
                    safeBrands.data.forEach { brand in
                        let brandCars = carList.filter { car in
                            car.brandID == brand.id
                        }
                        brandList.append(
                            MyBrand(
                                id: brand.id,
                                brandName: brand.brandName,
                                founderNames: brand.founderNames,
                                foundationDate: brand.foundationDate,
                                cars: brandCars
                            )
                        )
                    }
                }
                if let safeError = error {
                    errorHandler(safeError)
                }
            }
        }
        
    }
    
    
    
    private func errorHandler(_ error: NetworkErrors) {
        guard let delegate = output as? UIViewController else {
            return
        }
        
        switch error {
        case .failedUrl:
            AutoAlertsFabricPresentable.showWarningAlert(in: delegate,
                                                            title: "URL is bad",
                                                            message: "Ops, something happens with URL")
        case .emptyCity:
            AutoAlertsFabricPresentable.showWarningAlert(in: delegate,
                                                            title: "Wrong city",
                                                            message: "Ops, you typed nonexistent city")
        case .httpError(let networkError):
            AutoAlertsFabricPresentable.showWarningAlert(in: delegate,
                                                            title: "HTTP Error",
                                                            message: "Id: \(networkError.cod).\nMessage: \(networkError.message)")
        case .emptyCoordinates:
            AutoAlertsFabricPresentable.showWarningAlert(in: delegate,
                                                            title: "Wrong coordinates",
                                                            message: "Ops, you are on nonexistent coordinates")
        default:
            AutoAlertsFabricPresentable.showWarningAlert(in: delegate,
                                                            title: "Ops",
                                                            message: "Something goes wrong")
        }
    }
}
