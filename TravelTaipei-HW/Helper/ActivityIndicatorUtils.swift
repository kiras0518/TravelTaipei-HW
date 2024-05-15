//
//  ActivityIndicatorUtils.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/15.
//

import Foundation
import UIKit
import SnapKit

class LoadingView: UIView {
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(backgroundView)
        backgroundView.addSubview(activityIndicator)
        
        backgroundView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func startAnimating() {
        self.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        self.isHidden = true
        activityIndicator.stopAnimating()
    }
}

public final class ActivityIndicatorUtils {
    
    private static let loadingView = LoadingView()
    
    init() {
    }
    
    static func addActivityIndicator(to view: UIView) {
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    static func startAnimating() {
        loadingView.startAnimating()
    }
    
    static func stopAnimating() {
        loadingView.stopAnimating()
    }
}
