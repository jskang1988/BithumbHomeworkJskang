//
//  CoinListCell.swift
//  BithumbHomeworkJskang
//
//  Created by 강진석 on 2021/03/02.
//

import UIKit

class CoinListCell: UITableViewCell {
    
    @IBOutlet var symbolImageView: UIImageView!
    @IBOutlet var symbolNameLabel: UILabel!
    @IBOutlet var symbleKoreanNameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var changePercentLabel: UILabel!
    
    var cData:CoinData?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func updateData(coinData:CoinData?) {
        self.cData = coinData
        self.updateUI()
    }
    
    override func prepareForReuse() {
        self.priceLabel.text = ""
    }
    
    func updateUI() {
        if let data = self.cData {
            self.symbolNameLabel.text = data.currency.uppercased()
            self.symbleKoreanNameLabel.text = data.koreanName
            self.priceLabel.text = data.last.getCurrencyFormatString()
            self.symbolImageView.image = UIImage.init(named: data.currency.uppercased())
            
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
    }
    
}
