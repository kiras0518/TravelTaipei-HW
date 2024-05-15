//
//  AttractionsHeaderView.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/14.
//

import Foundation
import SnapKit
import UIKit

class AttractionsHeaderView: UIView {
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 236/255, green: 102/255, blue: 96/255, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "悠遊景點"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        updateTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
            //make.width.equalToSuperview().multipliedBy(0.35) // 寬度設置為畫面寬度的四分之三
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(16)
            make.bottom.equalTo(-16)
            //make.width.lessThanOrEqualTo(self.snp.width).offset(-32)
        }
    }
    
    private func updateTitle() {
        let title = LanguageManager.shared.getSpotsTitleForCurrentLanguage()
        titleLabel.text = title
    }
}
