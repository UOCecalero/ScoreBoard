//
//  SceneDelegate.swift
//  ScoreBoard
//
//  Created by Edu Calero on 08/08/2020.
//  Copyright © 2020 Iflet.tech. All rights reserved.
//

import UIKit
import SwiftUI
import Firebase
import FirebaseAuthUI
import FirebaseEmailAuthUI
import FirebasePhoneAuthUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).


        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            let firebaseViewController = self.firebaseConfig()
            window.rootViewController = firebaseViewController
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

extension SceneDelegate: FUIAuthDelegate {
    
    fileprivate func firebaseConfig() -> UINavigationController? {
        FirebaseApp.configure()
        
        let authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        
        let emailAuth = emailProviderConstructor()

        let providers: [FUIAuthProvider] = [
            emailAuth,
            FUIPhoneAuth(authUI: FUIAuth.defaultAuthUI()!)
        ]
        authUI?.providers = providers
        return authUI?.authViewController()
    }
            
    fileprivate func emailProviderConstructor() -> FUIEmailAuth {
//            var actionCodeSettings = ActionCodeSettings()
//            actionCodeSettings.url = URL(string: "https://www.iflet.tech")
//            actionCodeSettings.handleCodeInApp = true
//            actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        
        return FUIEmailAuth(authAuthUI: FUIAuth.defaultAuthUI()!,
                            signInMethod: EmailPasswordAuthSignInMethod, //EmailLinkAuthSignInMethod
                            forceSameDevice: false,
                            allowNewEmailAccounts: true,
                            actionCodeSetting: ActionCodeSettings())
        }
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        guard error == nil,
        let authDataResult = authDataResult
        else {
            let alert = UIAlertController(title: "ERROR", message: "\(error.debugDescription)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.window?.topMostViewController.present(alert, animated: true, completion: nil)
            return
        }
    
        //TODO: Send email to check verification
//        guard authDataResult.user.isEmailVerified else {
//            let alert = UIAlertController(title: "WARNING", message: "Please verify your email to get access", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//            self.window?.topMostViewController.present(alert, animated: true, completion: nil)
//            return
//        }
        
        let mainView = MainView()
        window?.rootViewController = UIHostingController(rootView: mainView)
    }
}

