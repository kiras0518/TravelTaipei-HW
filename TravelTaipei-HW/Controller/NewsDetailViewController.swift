//
//  NewsDetailViewController.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/14.
//

import Foundation
import UIKit

class NewsDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // 接收傳遞的資料
    var defaultNewsData: NewsModel = NewsModel(id: nil, title: nil, description: nil, begin: nil, end: nil, posted: nil, modified: nil, url: nil, files: nil, links: nil)
    var newsData: NewsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "NewsDetailTableViewCell", bundle: nil), forCellReuseIdentifier: NewsDetailTableViewCell.identifier)
    }
    
}

extension NewsDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsDetailTableViewCell.identifier, for: indexPath) as? NewsDetailTableViewCell else {
            return UITableViewCell()
        }
        
        if let newsData = newsData {
            cell.configure(with: newsData)
        } else {
            cell.configure(with: defaultNewsData)
        }
        
        return cell
        
    }
}
