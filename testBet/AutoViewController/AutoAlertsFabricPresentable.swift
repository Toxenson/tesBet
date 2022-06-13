//
//  AutoAlertsFabricPresentable.swift
//  testBet
//
//  Created by Тоха on 13.06.2022.
//
import UIKit

struct AutoAlertsFabricPresentable {
    
    private static func getWarningAlert(title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK",
                                        style: .default,
                                        handler: nil)
        alertController.addAction(alertAction)
        return alertController
    }
    
    static func showWarningAlert(in viewController: UIViewController, title: String, message: String) {
        viewController.present(getWarningAlert(title: title,
                                   message: message),
                   animated: true,
                   completion: nil)
    }
}
