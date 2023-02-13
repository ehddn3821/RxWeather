//
//  ViewController.swift
//  RxWeather
//
//  Created by dwKang on 2023/02/11.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa

class ViewController: BaseViewController, View {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
    }
    
    func bind(reactor: ViewReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.fetchWeather("Seoul") }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap { $0.weatherResponse }
            .bind { res in
                print(res)
            }.disposed(by: disposeBag)
        
        reactor.state
            .compactMap { $0.weatherError }
            .subscribe { error in
                print(error)
            }.disposed(by: disposeBag)
    }
}

