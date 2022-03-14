//
//  InfinityTableView.swift
//  ImageScroller
//
//  Created by MacBook on 11.03.2022.
//

import UIKit
import SnapKit
import SDWebImage

class InfinityTableView: UIView  {
    
    let imageDownloading = ImageDownloading()
    
    var downloadedData: SearchedImages = SearchedImages(total: 0, totalHits: 0, hits: [])
    
    private var viewcontainer: UIView!
    private let tableView = UITableView()
    
    private let identifire = "OneImage"

    
    init() {
        super.init(frame: CGRect.zero)
        setupViewContainer()
//        setupTableView()
        imageDownloading.GetNewSong { d in
            if let data = d  {
                self.downloadedData = data
                DispatchQueue.main.async {
                    self.setupTableView()
                }
            }
            else {
                print("No data returned")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK:  Функции для создания элементов вью

    func setupViewContainer() {
        viewcontainer = UIView()
        viewcontainer.backgroundColor = .white
        self.addSubview(viewcontainer)
        viewcontainer.snp.makeConstraints { make in
            make.right.equalTo(self).offset(-20)
            make.left.equalTo(self).offset(20)
            make.width.lessThanOrEqualTo(500)
            make.height.equalTo(UIScreen.main.bounds.height)

        }
    }
    
    func setupTableView() {
        tableView.register(InfinityTableViewCell.self, forCellReuseIdentifier: identifire)
        tableView.delegate = self
        tableView.dataSource = self
        viewcontainer.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(viewcontainer).inset(55)
            make.width.equalTo(viewcontainer)
            make.bottom.equalTo(viewcontainer).inset(20)
        }
    }
}


extension InfinityTableView:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (downloadedData.total < 20) {downloadedData.total ?? 20}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath) as! InfinityTableViewCell
        let currentImageURL = downloadedData.hits[indexPath.row].webformatURL
        guard let url = URL(string: currentImageURL) else {return cell}
        cell.myImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "imagePlaceholder"), options: [.continueInBackground, .progressiveLoad])
        cell.myImageView.backgroundColor = .black
        cell.addSubview(cell.myImageView)
        cell.myImageView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().inset(40)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.width + 80
    }
}
