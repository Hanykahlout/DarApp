//
//  AppDelegate.swift
//  darApp
//
//  Created by Hani Mac on 25/07/2021.
//

import UIKit
import GoogleMaps
import Firebase
import GoogleSignIn
import FBSDKCoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyC92xzy6OmVSdjuL6fFh6pg7P45skA4VLQ")
        FirebaseApp.configure()
        GIDSignIn.sharedInstance()?.clientID = "849176790178-puevaekk08kh7ov99coet0dt3nt7slrt.apps.googleusercontent.com"
        ApplicationDelegate.shared.application(
                    application,
                    didFinishLaunchingWithOptions: launchOptions
                )
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

// MARK:- Google SignIn

extension AppDelegate{
    
//    func application(_ application: UIApplication, open url: URL,
//                     options: [UIApplication.OpenURLOptionsKey: Any])
//      -> Bool {
//        
//        ApplicationDelegate.shared.application(
//            application,
//            open: url,
//            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
//            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
//        )
//        
//        return GIDSignIn.sharedInstance()!.handle(url)
//    }
    
}


