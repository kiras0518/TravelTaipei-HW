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
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var goAction: UIButton!
    @IBOutlet weak var openLb: UILabel!
    @IBOutlet weak var addressLb: UILabel!
    @IBOutlet weak var phoneLb: UILabel!
    @IBOutlet weak var websiteLb: UILabel!
    
    @IBAction func goWebAction(_ sender: UIButton) {
        openWebViewButtonTapped()
    }
    
    var attractionsData: AttractionsModel?
    
    // UI 元件
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupScrollView()
        setupPageControl()
        setupConstraints()
    }
    
    private func setupViews() {
        textView.text = attractionsData?.introduction ?? ""
        openLb.text = "營業時間：\(attractionsData?.open_time ?? "")"
        addressLb.text = "地址：\(attractionsData?.address ?? "")"
        phoneLb.text = "聯絡電話：\(attractionsData?.tel ?? "")"
        websiteLb.text = "網址：\(attractionsData?.url ?? "")"
        view.addSubview(scrollView)
        view.addSubview(pageControl)
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


