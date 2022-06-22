//
//  MyViewController.swift
//  SolidSample
//
//  Created by Juan Munhoes Junior on 22/06/22.
//

import UIKit

protocol IMyViewController {
    func setup()
}

final class MyViewController: BaseViewController, IMyViewController {
    
    func setup() {
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator?.color = .red
        navigationTitle = "Hi Liskov :)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setNavigation()
    }
}
