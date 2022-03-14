//
//  InfinityTableViewCell.swift
//  ImageScroller
//
//  Created by MacBook on 11.03.2022.
//

import UIKit
import SnapKit


class InfinityTableViewCell :UITableViewCell {
    
    let subTitleForImage = UILabel()
    let number = UILabel()
    let myimage = UIImage()
    var myImageView = UIImageView()

    
    var deleteButtonAction : (() -> ())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        makeConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("Fatal error")
    }
    func addViews() {
        subTitleForImage.text = "Description"
//        contentView.addSubview(myImageView)
        contentView.addSubview(subTitleForImage)
//        contentView.addSubview(number)
    }
    func makeConstraints() {
        subTitleForImage.snp.makeConstraints { make in
            make.bottom.equalTo(contentView)
            make.width.equalTo(contentView)
            make.height.equalTo(80)
        }
    }
}
