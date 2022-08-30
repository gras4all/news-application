//
//  NewsListViewController.swift
//  mvpExample
//
//  Created by Андрей Груненков on 15.08.2022.
//

import UIKit
import PinLayout

final class NewsListViewController: UIViewController {
    
    var presenter: NewsListPresenterProtocol!
    
    let searchField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.alwaysBounceVertical = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.allowsMultipleSelection = false
        tableView.isExclusiveTouch = true
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    let loaderView: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.style = .large
        loader.color = .gray
        return loader
    }()
    
    var sortButton: UIBarButtonItem?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigationBar()
        presenter.requestNews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeLayout()
    }

}

//MARK: - NewsListViewInConnection
extension NewsListViewController: NewsListViewInConnection {
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    func showLoader() {
        view.addSubview(loaderView)
        loaderView.startAnimating()
    }
    
    func hideLoader() {
        loaderView.stopAnimating()
        loaderView.removeFromSuperview()
    }
    
    func showSort(kind: SortKind) {
        self.navigationItem.rightBarButtonItems?[0].image = kind.getImage()
    }
    
}

//MARK: - private methods
private extension NewsListViewController {
    
    func setupViews() {
        self.view.addSubviews([
            searchField,
            tableView
        ])
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(NewsListCell.self, forCellReuseIdentifier: String(describing: NewsListCell.self))
        searchField.addTarget(self, action: #selector(textFieldDidChange),
                                  for: .editingChanged)
    }
    
    func setupNavigationBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "News"
        let sortButton = UIBarButtonItem(image: SortKind.date.getImage(), style: .plain, target: self, action: #selector(tapSortButton))
        self.navigationItem.rightBarButtonItems = [sortButton]
    }
    
    func makeLayout() {
        searchField.pin.top(view.pin.safeArea)
            .left(view.pin.safeArea + 16)
            .right(view.pin.safeArea + 16)
            .height(40)
        
        tableView.pin.below(of: searchField)
            .marginTop(10)
            .left(view.pin.safeArea + 16)
            .right(view.pin.safeArea + 16)
            .bottom(view.pin.safeArea)
        
        loaderView.pin.center(to: view.anchor.center)
            .height(40)
            .width(40)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let query = textField.text else { return }
        presenter.requestNews(query: query, withDelay: true)
    }
    
    @objc func tapSortButton() {
        openSortMenu()
    }
    
    func openSortMenu() {
        let byDateAction = UIAlertAction(title: "By date",
                                         style: .default) { [weak self] _ in
            guard let _self = self else { return }
            _self.presenter.sortSelected(kind: .date)
        }
        let byPopularityAction = UIAlertAction(title: "By popularity",
                                            style: .default) { [weak self] _ in
            guard let _self = self else { return }
            _self.presenter.sortSelected(kind: .popular)
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .destructive,
                                         handler: nil)
        let alertController = AlertsBuilder
            .buildSortActionsMenu(menuItems: [byDateAction,
                                              byPopularityAction,
                                              cancelAction])
        self.present(alertController, animated: true, completion: nil)
    }
    
}
