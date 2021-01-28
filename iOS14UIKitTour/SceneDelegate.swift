//
//  SceneDelegate.swift
//  iOS14UIKitTour
//
//  Created by Ivan Corchado Ruiz on 1/24/21.
//  Copyright © 2021 ivancr. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = scene as? UIWindowScene else { return }

        let splitVC = SplitViewController(style: .doubleColumn)
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = splitVC
        self.window = window
        window.makeKeyAndVisible()
    }
}
