//
//  UITableView+Extension.swift
//  Coins
//
//  Created by eyup cimen on 25.02.2022.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerClass(cellClass: AnyClass) {
        let className = String.init(describing: cellClass)
        
        if let _ = Bundle.main.path(forResource: className, ofType: "nib") {
            self.register(UINib.init(nibName: className, bundle: nil), forCellReuseIdentifier: className)
        } else {
            self.register(cellClass, forCellReuseIdentifier: className)
        }
    }

    func registerHeaderClass(cellClass: AnyClass) {
        let className = String.init(describing: cellClass)
        
        if let _ = Bundle.main.path(forResource: className, ofType: "nib") {
            self.register(UINib.init(nibName: className, bundle: nil), forHeaderFooterViewReuseIdentifier: className)
        } else {
            self.register(cellClass, forHeaderFooterViewReuseIdentifier: className)
        }
    }
    
    func registerNibCells(classNames: [AnyClass]) {
        if classNames.count > 0 {
            for className in classNames {
                self.registerClass(cellClass: className)
            }
        }
    } 
    
}
