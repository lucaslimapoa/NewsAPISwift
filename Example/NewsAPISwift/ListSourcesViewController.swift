//
//  ListSourcesViewController.swift
//  NewsAPISwift
//
//  Created by lucas lima on 6/3/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import NewsAPISwift

class ListSourcesViewController: UITableViewController {

    let newsAPI = NewsAPI(key: "3d188ee285764cb196fd491913960a24")
    var sources = [NewsAPISource]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NewsAPISwift"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        newsAPI.getSources { result in
            switch result {
            case .success(let sourceList):
                self.sources = sourceList
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articlesViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "ListArticlesViewController") as! ListArticlesViewController
        
        articlesViewController.newsAPI = newsAPI
        articlesViewController.source = sources[indexPath.row]
        
        navigationController?.pushViewController(articlesViewController, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SourceCell", for: indexPath)
    
        if let name = sources[indexPath.row].name {
            cell.textLabel?.text = name
        }
        
        return cell
    }
}
