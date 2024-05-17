//
//  AttractionsDetailViewController.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/14.
//

import Foundation
import UIKit
import WebKit
import SnapKit
import Kingfisher

class AttractionsDetailViewController: UIViewController, UIScrollViewDelegate {

    var attractionsData: AttractionsModel?
    
    // UI 元件
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        return pageControl
    }()
    
    lazy var textView2: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.text = attractionsData?.introduction ?? ""
        textView.font = .systemFont(ofSize: 14)
        textView.layer.cornerRadius = 8
        return textView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        return stackView
    }()
    
    lazy var openLabel: UILabel = {
        let label = UILabel()
        label.text = "營業時間：\(attractionsData?.open_time ?? "")"
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "地址：\(attractionsData?.address ?? "")"
        return label
    }()
    
    lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "聯絡電話：\(attractionsData?.tel ?? "")"
        return label
    }()
    
    lazy var websiteLabel: UILabel = {
        let label = UILabel()
        label.text = "網址：\(attractionsData?.url ?? "")"
        return label
    }()
    
    lazy var goWebButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("前往官網", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(goWebSite(_:)), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 229/255, green: 172/255, blue: 67/255, alpha: 1)
        button.layer.cornerRadius = 8
        return button
    }()
    
    @objc private func goWebSite(_ sender: UIButton) {
        let webVC = WebViewController()
        webVC.urlString = attractionsData?.url ?? ""
        present(webVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupStackView()
        setupScrollView()
        setupPageControl()
        setupConstraints()
    }
    
    private func setupStackView() {
        stackView.addArrangedSubview(openLabel)
        stackView.addArrangedSubview(addressLabel)
        stackView.addArrangedSubview(phoneLabel)
        stackView.addArrangedSubview(websiteLabel)
        stackView.addArrangedSubview(goWebButton)
    }
    
    private func setupViews() {
        
        view.addSubview(scrollView)
        view.addSubview(pageControl)
        view.addSubview(stackView)
        view.addSubview(textView2)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)  // ScrollView 對齊到頂部
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(260)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(4)  // PageControl 在 ScrollView 下方
            make.centerX.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        textView2.snp.makeConstraints { make in
                make.top.equalTo(stackView.snp.bottom).offset(16)
                make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(stackView).multipliedBy(1.15)
                make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
            }
    }
    
    
    private func setupScrollView() {
        
        scrollView.delegate = self
        
        guard let attractions = attractionsData else { return }
        
        // 安全解包 images
        if let images = attractions.images {
            var previousImageView: UIImageView?
            
            for (index, imageUrl) in images.enumerated() {
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFit
                imageView.kf.setImage(with: URL(string: imageUrl.src ?? ""))
                
                scrollView.addSubview(imageView)
                imageView.snp.makeConstraints { make in
                    make.top.equalToSuperview()  // 頂部對齊
                    make.height.equalTo(300)  // 固定高度
                    make.width.equalTo(view.snp.width)
                    
                    if let previous = previousImageView {
                        make.left.equalTo(previous.snp.right)
                    } else {
                        make.left.equalTo(scrollView.snp.left)
                    }
                    
                    if index == images.count - 1 {
                        make.right.equalTo(scrollView.snp.right)
                    }
                }
                
                previousImageView = imageView
            }
        }
    }
    
    private func setupPageControl() {
        guard let attractionsData = attractionsData else { return }
        pageControl.numberOfPages = attractionsData.images?.count ?? 1
    }
    
    // ScrollView 代理方法
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    private func openWebViewButtonTapped() {
        let webVC = WebViewController()
        webVC.urlString = attractionsData?.url ?? ""
        present(webVC, animated: true)
    }
}


