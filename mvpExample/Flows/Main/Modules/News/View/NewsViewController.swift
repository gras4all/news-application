//
//  NewsViewController.swift
//  mvpExample
//
//  Created by Андрей Груненков on 15.08.2022.
//

import Foundation
import UIKit
import PinLayout
import Kingfisher

final class NewsViewController: UIViewController, NewsViewInConnection {
    
    var presenter: NewsPresenterProtocol!
    
    var articleImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
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
    
    var linkButton: UITextView = {
        let button = UITextView()
        button.textColor = .blue
        button.backgroundColor = .white
        button.textContainer.maximumNumberOfLines = 1
        button.textContainer.lineBreakMode = .byTruncatingTail
        button.isEditable = false
        button.dataDetectorTypes = .link
        button.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        setupViews()
        bindData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeLayout()
    }
    
}

//MARK: - private methods
private extension NewsViewController {
    
    func setupViews() {
        view.addSubviews([
            articleImage,
            descriptionLabel,
            dateLabel,
            linkButton
        ])
        view.backgroundColor = .white
    }
    
    func bindData() {
        let data = presenter.getArticle()
        self.title = data.title
        if  let urlString = data.urlToImage,
            let url = URL(string: urlString) {
            self.articleImage.kf.setImage(with: url,
                                          placeholder: UIImage(named: "articlePlaceholder"))
        }
        descriptionLabel.text = data.description
        linkButton.text = data.url
        if let date = data.date {
            dateLabel.text = DatesHelper.dateToString(from: date,
                                                      pattern: "yyyy-MM-dd")
        }
    }
    
    func makeLayout() {
        articleImage.pin.top(view.pin.safeArea)
            .left(view.pin.safeArea)
            .right(view.pin.safeArea)
            .height(250)
        
        descriptionLabel.pin.below(of: articleImage)
            .marginTop(10)
            .left(16)
            .right(16)
            .sizeToFit(.width)
        
        linkButton.pin.below(of: descriptionLabel)
            .marginTop(5)
            .left(16)
            .right(16)
            .sizeToFit(.width)
        
        dateLabel.pin.below(of: linkButton)
            .marginTop(5)
            .left(16)
            .right(16)
            .sizeToFit(.width)
    }
    
}
