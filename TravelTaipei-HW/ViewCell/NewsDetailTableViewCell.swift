//
//  NewsDetailTableViewCell.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/11.
//

import UIKit

class NewsDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var postedLb: UILabel!
    @IBOutlet weak var modifiedLb: UILabel!
    @IBOutlet weak var descLb: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    static let identifier = "NewsDetailTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLb.numberOfLines = 0
        descLb.numberOfLines = 0
        bgView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with news: NewsModel) {
        titleLb.text = news.title
        postedLb.text = news.posted
        modifiedLb.text = news.modified
        descLb.text = news.description
    }
    
}
