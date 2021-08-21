//
//  UIWindow.swift
//  ScoreBoard
//
//  Created by Eduard Calero on 1/8/21.
//  Copyright © 2021 Iflet.tech. All rights reserved.
//

import UIKit

extension UIWindow {
    
    var topMostViewController: UIViewController {
        if var topController = self.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            return topController
        }
        
        return self.rootViewController ?? UIViewController()
    }
 }
