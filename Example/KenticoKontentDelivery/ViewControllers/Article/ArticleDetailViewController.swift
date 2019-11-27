//
//  ArticleDetailViewController.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 21/08/2017.
//  Copyright © 2017 Kentico Software. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    
    // MARK: Properties
    
    var article: Article?
    var image: UIImage?
    
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var content: UILabel!
    @IBOutlet var backButton: UIButton!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        backButton.stylePinkButton()
        
        if let body = article?.bodyCopy?.htmlContentString {
            content.styleWithRichtextString(richtextString: body)
        }
        
        if let image = image {
            titleImage.image = image
        }
        
        if let article = article{
            self.articleTitle.text = article.title?.value
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Outlet actions

    @IBAction func navigateBack(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
}
