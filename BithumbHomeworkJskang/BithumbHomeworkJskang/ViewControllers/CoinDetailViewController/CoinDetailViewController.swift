//
//  CoinDetailViewController.swift
//  BithumbHomeworkJskang
//
//  Created by 강진석 on 2021/03/03.
//

import UIKit

protocol CoinDetailViewControllerDelegate {
    func onDetailViewControllerClosed()
}

class CoinDetailViewController: UIViewController {
    
    var coinData:CoinData?
    
    @IBOutlet var bookmarkImageView: UIImageView!
    @IBOutlet var symbolNameLabel: UILabel!
    @IBOutlet var koreanNameLabel: UILabel!
    
    @IBOutlet var symbolImageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var changePercentLabel: UILabel!
    
    @IBOutlet var chartView: UIView!
    
    var delegate:CoinDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingSubviews()
        self.updateBookmark()
        
    }
    
    func settingSubviews() {
        if let data = self.coinData {
            self.symbolNameLabel.text = data.currency.uppercased()
            self.koreanNameLabel.text = data.koreanName
            self.symbolImageView.image = UIImage.init(named: data.currency.uppercased())
            self.priceLabel.text = data.last.getCurrencyFormatString()
            if data.changePercent > 0 {
                self.changePercentLabel.text = "+\(data.changePercent.getPercentFormatString())%"
                self.changePercentLabel.textColor = .red
                self.priceLabel.textColor = .red
            }
            else if data.changePercent < 0 {
                self.changePercentLabel.text = "\(data.changePercent.getPercentFormatString())%"
                self.priceLabel.textColor = .blue
                self.changePercentLabel.textColor = .blue
            }
            else {
                self.changePercentLabel.text = "\(data.changePercent.getPercentFormatString())%"
                self.priceLabel.textColor = .black
                self.changePercentLabel.textColor = .black
            }
        }
        
        self.chartView.layer.borderWidth = 2.0
        self.chartView.layer.borderColor = UIColor.black.cgColor
        self.chartView.layer.cornerRadius = 5.0
    }

    @IBAction func onClickBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.onDetailViewControllerClosed()
    }
    
    @IBAction func onClickBookmark(_ sender: Any) {
        if let data = self.coinData {
            if BookmarkUserDefaultManager.shared.isExistCurrency(currency: data.currency) {
                BookmarkUserDefaultManager.shared.removeCurrency(currency: data.currency)
            }
            else {
                BookmarkUserDefaultManager.shared.addCurrency(currency: data.currency)
            }
            self.updateBookmark()
        }
    }
    
    func updateBookmark() {
        if let data = self.coinData {
            if BookmarkUserDefaultManager.shared.isExistCurrency(currency: data.currency) {
                self.bookmarkImageView.image = UIImage.init(systemName: "star.fill")
            }
            else {
                self.bookmarkImageView.image = UIImage.init(systemName: "star")
            }
        }
    }
}
