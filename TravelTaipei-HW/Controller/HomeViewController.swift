//
//  HomeViewController.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/12.
//

import Foundation
import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var langBtn: UIBarButtonItem!
    
    @IBAction func langBtnTapped(_ sender: Any) {
        changeLanguage()
    }
    
    private let newsViewModel: NewsViewModel = NewsViewModel()
    private let attviewModel: AttractionViewModel = AttractionViewModel()
    
    private let headerView = NewsHeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 60))
    
    private let dispatchGroup = DispatchGroup()
    
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100 // 預估的高度，可以根據需要調整
        
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: NewsTableViewCell.identifier)
        tableView.register(UINib(nibName: "AttractionsTableViewCell", bundle: nil), forCellReuseIdentifier: AttractionsTableViewCell.identifier)
        
        ActivityIndicatorUtils.addActivityIndicator(to: view)
        ActivityIndicatorUtils.startAnimating()
        
        navigationItem.title = "悠遊台北"
    }
    
    private func updateTitle() {
        let title = LanguageManager.shared.getBarTitleForCurrentLanguage()
        navigationItem.title = title
    }
    
    private func fetchData() {
        dispatchGroup.enter()
        newsViewModel.getNews(begin: nil, end: nil, page: 1)
 
        dispatchGroup.enter()
        attviewModel.getAttraction(categoryIds: nil, nlat: nil, elong: nil, page: 1)
        
        // 監控 dispatch group，所有請求完成後停止動畫
        dispatchGroup.notify(queue: .main) {
            ActivityIndicatorUtils.stopAnimating()
        }
    }
    
    private func setupObservers() {
        // 監聽資料變化, 更新列表
        newsViewModel.newsData.addObserver(self) { [weak self] in
            self?.tableView.reloadData()
            self?.dispatchGroup.leave()
        }
        
        attviewModel.attractionsData.addObserver(self) { [weak self] in
            self?.tableView.reloadData()
            self?.dispatchGroup.leave()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        fetchData()
        setupObservers()
    }
    
}

extension HomeViewController {
    
    private func changeLanguage() {
        
        let languages: [LanguageCode] = [.zhTW, .zhCN, .en, .ja, .ko, .es, .id, .th, .vi]
        
        AlertUtils.showLanguageSelectionAlert(languages: languages,
                                              presentingViewController: self) { [weak self] selectedLanguage in
            self?.updateLanguage(to: selectedLanguage)
        }
    }
    
    private func updateLanguage(to language: LanguageCode) {
        LanguageManager.shared.currentLanguage = language
        
        // Reload data with the new language
        newsViewModel.getNews(begin: nil, end: nil, page: 1)
        attviewModel.getAttraction(categoryIds: nil, nlat: nil, elong: nil, page: 1)
        updateTitle()
    }
    
    private func navigateToDetail(with data: NewsModel) {
        
        guard let attractionsDetailVC = storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as? NewsDetailViewController else {
            return
        }
        // 傳遞資料到 AttractionsDetailViewController
        attractionsDetailVC.newsData = data
        attractionsDetailVC.navigationItem.title = LanguageManager.shared.getNewsTitleForCurrentLanguage()
        navigationController?.pushViewController(attractionsDetailVC, animated: true)
    }
    
    private func navigateToAttractionDetail(with data: AttractionsModel) {
        
        guard let attractionsDetailVC = storyboard?.instantiateViewController(withIdentifier: "AttractionsDetailViewController") as? AttractionsDetailViewController else {
            return
        }
        
        attractionsDetailVC.attractionsData = data
        attractionsDetailVC.navigationItem.title = LanguageManager.shared.getSpotsTitleForCurrentLanguage()
        navigationController?.pushViewController(attractionsDetailVC, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return NewsHeaderView()
        case 1:
            return AttractionsHeaderView()
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return newsViewModel.newsData.value.count
        case 1:
            return attviewModel.attractionsData.value.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard indexPath.row < newsViewModel.newsData.value.count,
                  let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
                return UITableViewCell()
            }
            
            let news = newsViewModel.newsData.value[indexPath.row]
            cell.configure(with: news)
            return cell
            
        case 1:
            guard indexPath.row < attviewModel.attractionsData.value.count,
                  let cell = tableView.dequeueReusableCell(withIdentifier: AttractionsTableViewCell.identifier, for: indexPath) as? AttractionsTableViewCell else {
                return UITableViewCell()
            }
            
            let data = attviewModel.attractionsData.value[indexPath.row]
            cell.configure(with: data)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            guard indexPath.row < newsViewModel.newsData.value.count else { return }
            let selectedNews = newsViewModel.newsData.value[indexPath.row]
            navigateToDetail(with: selectedNews)
        case 1:
            guard indexPath.row < attviewModel.attractionsData.value.count else { return }
            let selectedAttraction = attviewModel.attractionsData.value[indexPath.row]
            navigateToAttractionDetail(with: selectedAttraction)
        default:
            break
        }
    }
}
