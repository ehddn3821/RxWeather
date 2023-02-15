//
//  SceneDelegate.swift
//  RxWeather
//
//  Created by dwKang on 2023/02/11.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let rootVC = WeatherViewController()
        let service = WeatherService()
        let reactor = WeatherViewReactor(service: service)
        rootVC.reactor = reactor
        let navRootVC = UINavigationController(rootViewController: rootVC)
        window?.rootViewController = navRootVC
        window?.makeKeyAndVisible()
    }
}

