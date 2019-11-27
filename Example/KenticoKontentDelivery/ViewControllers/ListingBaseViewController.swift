//
//  ListingBaseViewController.swift
//  KenticoKontentDelivery
//
//  Created by Martin Makarsky on 01/10/2017.
//  Copyright © 2017 Kentico Software. All rights reserved.
//

import UIKit

class ListingBaseViewController: UIViewController {
    
    // MARK: Properties
    
    var loader: UIAlertController!
    
    // MARK: Behaviour
    
    func showLoader(message: String) {
        
        loader = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        loader.view.addSubview(loadingIndicator)
        self.view.window?.rootViewController?.present(loader, animated: true, completion: nil)
    }
    
    func hideLoader() {
        self.loader.dismiss(animated: false, completion: nil)
    }
}
