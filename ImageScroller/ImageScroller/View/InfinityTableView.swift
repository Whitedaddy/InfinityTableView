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
    
    private var page = 1
//    private var isLoading = true

    
    init() {
        super.init(frame: CGRect.zero)
        setupViewContainer()
        imageDownloading.GetNewSong(page: page) { d in
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
    
    //Хранилище для вью
    func setupViewContainer() {
        viewcontainer = UIView()
        viewcontainer.backgroundColor = .black
        self.addSubview(viewcontainer)
        viewcontainer.snp.makeConstraints { make in
            make.right.equalTo(self)
            make.left.equalTo(self)
            make.width.lessThanOrEqualTo(500)
            make.height.equalTo(UIScreen.main.bounds.height)

        }
    }
    //Таблица
    func setupTableView() {
        tableView.register(InfinityTableViewCell.self, forCellReuseIdentifier: identifire)
        tableView.register(InfinitytableViewLoadingCell.self, forCellReuseIdentifier: "LoadingCell")
        tableView.delegate = self
        tableView.dataSource = self
        viewcontainer.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(viewcontainer).inset(55)
            make.width.equalTo(viewcontainer)
            make.bottom.equalTo(viewcontainer).inset(40)
        }
    }
}

    // Методы для таблицы
extension InfinityTableView:  UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return downloadedData.hits.count
        }
        else if section == 1 {
            return 1
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath) as! InfinityTableViewCell
            
            cell.subTitleForImage.text = "\(downloadedData.hits[indexPath.row].tags)"
            
            cell.cellID.text = String(indexPath.row)
            
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
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! InfinitytableViewLoadingCell
            cell.activityIndicator.startAnimating()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.width + 80
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
//        print("offset = \(offsetY), contentHeight = \(contentHeight)")
        if (offsetY > contentHeight - scrollView.frame.size.height) {
            print("load new data")
            page += 1
            imageDownloading.GetNewSong(page: page) { data in
                self.downloadedData.hits.append(contentsOf: data!.hits)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
