//
//  ArticlesViewController.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 21/08/2017.
//  Copyright © 2017 Kentico Software. All rights reserved.
//

import UIKit
import KenticoKontentDelivery
import AlamofireImage

class ArticlesViewController: ListingBaseViewController, UITableViewDataSource {
    
    // MARK: Properties
    
    private let contentType = "article"
    private var articles: [Article] = []
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        if articles.count == 0 {
            getArticles()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell") as! ArticleTableViewCell
        cell.photo.addBorder()
        
        let article = articles[indexPath.row]
        cell.title.text = article.title?.value
        cell.summary.text = article.summary?.value
        
        if let date = article.postDate?.value {
            cell.date.text = date.getDateString()
        }
        
        if let assets = article.asset?.value {
            if assets.count > 0 {
                let url = URL(string: assets[0].url!)
                cell.photo.af_setImage(withURL: url!)
            } else {
                cell.photo.image = UIImage(named: "noContent")
            }
        } else {
            cell.photo.image = UIImage(named: "noContent")
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "articleDetailSegue" {
            
            let articleDetailViewController = segue.destination
                as! ArticleDetailViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow!
            articleDetailViewController.article = articles[indexPath.row]
            
            let cell = self.tableView.cellForRow(at: indexPath) as! ArticleTableViewCell
            
            if let image = cell.photo.image {
                articleDetailViewController.image = image
            } else {
                articleDetailViewController.image = UIImage(named: "noContent")
            }
        }
        
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    // MARK: Outlet actions
    
    @IBAction func refreshTable(_ sender: Any) {
        getArticles()
    }
    
    // MARK: Getting items
    
    private func getArticles() {
        self.showLoader(message: "Loading articles...")
        
        let deliveryClient = DeliveryClient.init(projectId: AppConstants.projectId)
        let customQuery = "items?system.type=article&order=elements.post_date[desc]"

        deliveryClient.getItems(modelType: Article.self, customQuery: customQuery) { (isSuccess, itemsResponse, error) in

            if isSuccess {
                if let articles = itemsResponse?.items {
                    self.articles = articles
                    self.tableView.reloadData()
                }
            } else {
                if let error = error {
                    print(error)
                }
            }
            
            DispatchQueue.main.async {
                self.finishLoadingItems()
            }
        }
    }
    
    func finishLoadingItems() {
        self.hideLoader()
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl?.endRefreshing()
        } else {
            // Fallback on earlier versions
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.tableView.contentOffset = CGPoint.zero
        })
    }
}

