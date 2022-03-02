//
//  StoryboardEnum.swift
//  Coins
//
//  Created by eyup cimen on 27.02.2022.
//

import Foundation
import UIKit

public enum CoinStoryboard: String {
    case coinList = "CoinList"
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    public func viewController<T: UIViewController>(with viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard")
        }
        return scene
    }
}
