//
//  AttractionsTableViewCell.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/12.
//

import UIKit
import Kingfisher

class AttractionsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var introLb: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    static let identifier = "AttractionsTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        photoImage.layer.cornerRadius = 12
        titleLb.layer.cornerRadius = 8
        titleLb.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with data: AttractionsModel) {
        titleLb.text = data.name
        introLb.text = data.introduction
        
        let placeholderImage = UIImage(systemName: "photo.artframe") // Your default image
        
        if let imageData = data.images?.first,
            let imageUrlString = imageData.src,
            let imageUrl = URL(string: imageUrlString) {
            photoImage.kf.setImage(with: imageUrl, placeholder: placeholderImage, options: [
                .transition(.fade(0.2)),
                .cacheOriginalImage
            ])
        } else {
            photoImage.image = placeholderImage
        }
    }
    
}
