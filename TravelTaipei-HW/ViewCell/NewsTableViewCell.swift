//
//  NewsTableViewCell.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/11.
//

import UIKit
import SnapKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var descLb: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    static let identifier = "NewsTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        titleLb.numberOfLines = 1
        descLb.numberOfLines = 3
        // 設置 BGView 的線框
        bgView.layer.borderWidth = 4.0
        bgView.layer.borderColor = CGColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        bgView.layer.cornerRadius = 12.0 
        bgView.clipsToBounds = true // 確保超出邊界的內容被裁剪
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with news: NewsModel) {
        titleLb.text = news.title
        descLb.text = news.description
    }
    
}
