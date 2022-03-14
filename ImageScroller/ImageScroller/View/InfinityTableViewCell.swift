//
//  InfinityTableViewCell.swift
//  ImageScroller
//
//  Created by MacBook on 11.03.2022.
//

import UIKit
import SnapKit


class InfinityTableViewCell :UITableViewCell {
    
    // MARK:  Переменные
    let subTitleForImage = UILabel()
    let tagsLabel = UILabel()
    var myImageView = UIImageView()

    var openImage : (() -> ())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        makeConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("Fatal error")
    }
    // MARK:  Функции для создания элементов вью
    //Создание вью
    func addViews() {
        subTitleForImage.textColor = .white
        subTitleForImage.font = .systemFont(ofSize: 20, weight: .light)
        contentView.addSubview(subTitleForImage)
        tagsLabel.textColor = .white
        tagsLabel.font = .boldSystemFont(ofSize: 20)
        contentView.addSubview(tagsLabel)
        contentView.backgroundColor = .black
    }
    //Создание констрэйнтов
    func makeConstraints() {
        tagsLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView)
            make.left.equalTo(contentView).inset(25)
            make.height.equalTo(80)
        }
        subTitleForImage.snp.makeConstraints { make in
            make.bottom.equalTo(contentView)
            make.left.equalTo(tagsLabel.snp.right)
            make.centerY.equalTo(tagsLabel)
        }
    }
}
