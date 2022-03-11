//
//  ViewController.swift
//  ImageScroller
//
//  Created by MacBook on 11.03.2022.
//

import UIKit

class ViewController: UIViewController {

    let imageDownloading = ImageDownloading()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageDownloading.GetNewSong()
    }


}

