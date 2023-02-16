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

final class MainViewController: BaseViewController, View {
    //MARK: Properties
    let searchBar = UISearchBar().then {
        $0.searchBarStyle = .minimal
        $0.placeholder = "Please enter a city name."
    }
    
    let goButton = UIButton().then {
        $0.backgroundColor = .systemBlue
        $0.setTitle("Go !", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.layer.cornerRadius = 8
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bind(reactor: MainViewReactor) {
        // Action
        searchBar.rx.text
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .filter { $0 != "" }
            .map { Reactor.Action.inputText($0!.lowercased()) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.searchResult }
            .bind(with: self) { owner, results in
                print(results)
            }.disposed(by: disposeBag)
    }
}
