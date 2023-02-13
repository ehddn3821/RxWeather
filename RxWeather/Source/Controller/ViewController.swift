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
import SkeletonView
import Then

class ViewController: BaseViewController, View {
    
    //MARK: Properties
    let countryLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    let cityNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 40, weight: .bold)
    }
    
    let iconView = UIView().then {
        $0.layer.cornerRadius = 40
        $0.layer.masksToBounds = true
    }
    
    let iconImageView = UIImageView().then {
        $0.isSkeletonable = true
    }
    
    let weatherLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 32, weight: .semibold)
    }
    
    let tempLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    
    let feelsLikeTempLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: Binding
    func bind(reactor: ViewReactor) {
        //TODO: 도시 이름 입력 받기
        // Action
        self.rx.viewDidLoad
            .map { Reactor.Action.fetchWeather("Tokyo") }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        reactor.state
            .compactMap { $0.weatherResponse }
            .bind(with: self) { owner, res in
                print(res)
                owner.iconImageView.showAnimatedGradientSkeleton()
                
                owner.countryLabel.text = res.sys.country
                owner.cityNameLabel.text = res.name
                owner.weatherLabel.text = res.weather.first!.main
                owner.tempLabel.text = res.main.temp.toCelsiusString
                owner.feelsLikeTempLabel.text = "Feels Like \(res.main.feels_like.toCelsiusString)"
                
                reactor.service.downloadIcon(res.weather.first!.icon)
                    .do(onNext: { _ in owner.iconImageView.hideSkeleton() })
                    .bind(to: owner.iconImageView.rx.image)
                    .disposed(by: owner.disposeBag)
                
            }.disposed(by: disposeBag)
        
        reactor.state
            .compactMap { $0.weatherError }
            .bind(with: self) { owner, error in
                let alert = UIAlertController(title: error.cod, message: error.message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                owner.present(alert, animated: true)
            }.disposed(by: disposeBag)
    }
}

