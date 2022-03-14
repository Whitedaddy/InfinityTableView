//
//  ViewController.swift
//  ImageScroller
//
//  Created by MacBook on 11.03.2022.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let infinityTableView = InfinityTableView ()
        view.addSubview(infinityTableView)
        infinityTableView.snp.makeConstraints
        { make in make.edges.equalTo(self.view) }
    }


}

