//
//  ListArticlesViewController.swift
//  NewsAPISwift
//
//  Created by lucas lima on 6/5/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import NewsAPISwift

class ListArticlesViewController: UITableViewController {

    var newsAPI: NewsAPI!
    var source: NewsSource!
    
//    var articles = [NewsAPIArticle]() {
//        didSet {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 44.0
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        navigationItem.title = source.name
//        
//        if let sourceId = source.id {
//            newsAPI.getArticles(sourceId: sourceId) { result in
//                switch result {
//                case .success(let articles):
//                    self.articles = articles
//                case .error(let error):
//                    fatalError("\(error)")
//                }
//            }
//        }
//    }
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return articles.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath)
//        
//        if let title = articles[indexPath.row].title {
//            cell.textLabel?.text = title
//        }
//        
//        return cell
//    }
}
