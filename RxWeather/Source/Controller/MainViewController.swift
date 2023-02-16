//
//  MainViewController.swift
//  RxWeather
//
//  Created by dwKang on 2023-02-15.
//

import UIKit
import ReactorKit
import Then
import RxCocoa
import RxSwift
import SnapKit

final class MainViewController: BaseViewController, View {
    
    //MARK: Properties
    
    let titleLabel = UILabel().then {
        $0.text = "OpenWeatherMap"
        $0.font = .systemFont(ofSize: 32, weight: .bold)
        $0.textColor = .black
    }
    
    let searchBar = UISearchBar().then {
        $0.searchBarStyle = .minimal
        $0.placeholder = "Please enter a city name..."
    }
    
    lazy var stackView = UIStackView(arrangedSubviews: [titleLabel, searchBar]).then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .equalSpacing
        $0.alignment = .center
    }
    
    lazy var resultTableView = UITableView().then {
        $0.isScrollEnabled = false
        $0.register(ResultTableViewCell.self, forCellReuseIdentifier: "cell")
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
    }
    
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addKeyboardNotificationCenter()
    }
    
    private func addKeyboardNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -160
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
    
    
    //MARK: - Binding
    
    func bind(reactor: MainViewReactor) {
        // Action
        searchBar.rx.text
            .skip(1)
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .map { $0 ?? "" }
            .do { text in
                if text == "" {
                    self.resultTableView.snp.updateConstraints {
                        $0.height.equalTo(0)
                    }
                    self.resultTableView.reloadData()
                }
            }
            .map { Reactor.Action.inputText($0.lowercased()) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.searchResult }
            .filter { !$0.isEmpty }
            .bind(with: self) { owner, results in
                print(results)
                owner.resultTableView.snp.updateConstraints {
                    $0.height.equalTo(results.count * 40)
                }
                owner.resultTableView.reloadData()
            }.disposed(by: disposeBag)
    }
}


//MARK: - TableView Delegate

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reactor!.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ResultTableViewCell else { return UITableViewCell() }
        self.reactor!.cellForRowAt(cell, indexRow: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.reactor!.presentToWeatherViewController(from: self, indexRow: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
