//
//  CoinListTableViewCell.swift
//  Coins
//
//  Created by eyup cimen on 26.02.2022.
//

import UIKit
import SVGKit
import SDWebImageSVGCoder

class CoinListTableViewCell: UITableViewCell {

    var imageStore: ImageStore!
    var viewModel: CoinListModel.SetUp.ViewModel.DisplayCoin! {
        didSet{
            bindViewModel()
        }
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
   
    func bindViewModel() {
        symbolLabel.text = viewModel.symbol
        nameLabel.text = viewModel.name
        if let priceDecimal = Decimal(string: viewModel.price) {
            priceLabel.text = NumberFormat.currencyFormatter(amount: priceDecimal)
        }
        if let changeDouble = Double( viewModel.change), let priceDouble = Double(viewModel.price) {
            let result = priceDouble * (changeDouble * 100)
            changeLabel.textColor = result > 0 ? .systemGreen : .systemRed
            var resultString = ""
            resultString = String(format: "%.2f", result) + "%"
            if result > 0 { // I know. It's a little bit horrible
                resultString.insert("+", at: resultString.startIndex )
            }
            changeLabel.text = resultString
        }

        if let image = self.imageStore.getImage(forKey: viewModel.uuid) {
            self.iconImageView.image = image
        } else {
            let coinImageUrl = viewModel.iconUrl
            if let url = URL(string: coinImageUrl) {
                DispatchQueue.global(qos: .background).async {
                    let SVGCoder = SDImageSVGCoder.shared
                    SDImageCodersManager.shared.addCoder(SVGCoder)
                    DispatchQueue.main.async {
                        self.iconImageView.sd_setImage(with: url)
                        if let image = self.iconImageView.image {
                            self.imageStore.setImage(image: image, forKey: self.viewModel.uuid)
                        }
                    }
                }
            }
        }
    } 
}
