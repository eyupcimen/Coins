//
//  HeaderView.swift
//  Coins
//
//  Created by eyup cimen on 26.02.2022.
//

import UIKit

protocol ChangeSortType {
    func changeSortTypeAction(sortType: SortType)
}

final class HeaderView: UITableViewHeaderFooterView {
         
    let sortType: SortType = .volume24
    var delegate: ChangeSortType?
    @IBOutlet weak var sortTypeLabel: UILabel!
    @IBOutlet weak var sortTypeView: DesignableView!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    } 
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    } 
     
    private func commonInit() {
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @IBAction func changeSortTypeAction(_ sender: UIButton) {
        guard let delegate = delegate else {return}
        delegate.changeSortTypeAction(sortType: self.sortType)
    }
  
    
    func setSortTypeLabelText(title:String) {
        DispatchQueue.main.async {
            self.sortTypeLabel.text = title
        }
    }
}
