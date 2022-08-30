//
//  NewsListCell.swift
//  mvpExample
//
//  Created by Андрей Груненков on 25.08.2022.
//

import UIKit
import PinLayout

final class NewsListCell: UITableViewCell {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    override func layoutSubviews() {
        makeLayout()
    }
    
}

extension NewsListCell {
    
    func setupViews() {
        backgroundColor = .white
        selectionStyle = .none
        contentView.addSubviews([
            titleLabel,
            descriptionLabel,
            dateLabel,
        ])
    }
    
    func makeLayout() {
        titleLabel.pin.top()
            .horizontally()
            .sizeToFit(.width)
        
        descriptionLabel.pin.below(of: titleLabel)
            .marginTop(10)
            .horizontally()
            .sizeToFit(.width)
        
        dateLabel.pin.below(of: descriptionLabel)
            .marginTop(10)
            .horizontally()
            .sizeToFit(.width)
        
    }
    
}

