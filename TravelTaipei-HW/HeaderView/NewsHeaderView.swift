//
//  NewsHeaderView.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/12.
//

import Foundation
import SnapKit
import UIKit

class NewsHeaderView: UIView {
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 236/255, green: 102/255, blue: 96/255, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "最新消息"
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
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(16)
            make.trailing.bottom.equalTo(-16)
        }
    }
    
    private func updateTitle() {
        let title = LanguageManager.shared.getNewsTitleForCurrentLanguage()
        titleLabel.text = title
    }
}
