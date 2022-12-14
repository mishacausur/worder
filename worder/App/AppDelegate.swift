//
//  AppDelegate.swift
//  worder
//
//  Created by Misha Causur on 07.11.2022.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        UINavigationBar.appearance().tintColor = .todayPrimaryTint
        UINavigationBar.appearance().backgroundColor = .todayNavigationBackground
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        return true
    }
}

