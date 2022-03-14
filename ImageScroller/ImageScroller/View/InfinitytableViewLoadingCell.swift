//
//  InfinitytableViewLoadingCell.swift
//  ImageScroller
//
//  Created by MacBook on 14.03.2022.
//

import UIKit

class InfinitytableViewLoadingCell: UITableViewCell {
    
    let activityIndicator = UIActivityIndicatorView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        makeConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("Fatal error")
    }

    func addViews() {
        contentView.addSubview(activityIndicator)
    }
    func makeConstraints() {
        activityIndicator.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}
