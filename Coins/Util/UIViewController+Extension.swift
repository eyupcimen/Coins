//
//  UIViewController+Extension.swift
//  Coins
//
//  Created by eyup cimen on 26.02.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(action)
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    class var storyboardID: String {
        return "\(self)"
    }
    
    var bottomSafeAreaHeight: CGFloat {
        guard let root = UIApplication.shared.keyWindow?.rootViewController else {
            return 0
        }
        let bottomSafeArea: CGFloat
        
        if #available(iOS 11.0, *) {
            bottomSafeArea = root.view.safeAreaInsets.bottom
        } else {
            bottomSafeArea = root.bottomLayoutGuide.length
        }
        return bottomSafeArea
    }
    
    func getNavBarHeight() -> CGFloat {
        guard let navigation = navigationController else {
            return UIApplication.shared.statusBarFrame.size.height
        }
        return UIApplication.shared.statusBarFrame.size.height + navigation.navigationBar.frame.height
    }
    
    var topSafeArea: CGFloat {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets.top
        } else {
            return topLayoutGuide.length
        }
    }
    
    var bottomSafeArea: CGFloat {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets.bottom
        } else {
            return bottomLayoutGuide.length
        }
        
    }
}
 
