//
//  BaseViewController.swift
//  SolidSample
//
//  Created by Juan Munhoes Junior on 22/06/22.
//

import UIKit

protocol IBaseLoading {
    var loadingIndicator: UIActivityIndicatorView? { get }
    func showLoadingIndicator(view: UIView)
    func hideLoadingIndicator()
}

protocol IBaseNavigationProtocol {
    var navigationTitle: String? { get }
    func setNavigation()
}

class BaseViewController: UIViewController, IBaseLoading, IBaseNavigationProtocol {
    var loadingIndicator: UIActivityIndicatorView?
    var navigationTitle: String?
    
    func showLoadingIndicator(view: UIView) {
        if let loadingIndicator = loadingIndicator {
            view.addSubview(loadingIndicator)
            loadingIndicator.startAnimating()
        }
    }
    
    func hideLoadingIndicator() {
        if let loadingIndicator = loadingIndicator {
            loadingIndicator.stopAnimating()
            loadingIndicator.removeFromSuperview()
        }
    }
    
    func setNavigation() {
        self.navigationController?.navigationBar.tintColor = .red
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.title = navigationTitle
    }
}
