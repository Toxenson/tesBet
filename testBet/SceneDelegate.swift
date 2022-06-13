//
//  SceneDelegate.swift
//  testBet
//
//  Created by Тоха on 12.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let presenter = AutoPresenter()
        let controller = AutoViewController()
        presenter.output = controller
        controller.presenter = presenter
        window?.rootViewController = controller
        window?.overrideUserInterfaceStyle = .light
        guard let _ = (scene as? UIWindowScene) else { return }
    }

}

