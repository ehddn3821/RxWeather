//
//  MainViewController+UI.swift
//  RxWeather
//
//  Created by dwKang on 2023-02-16.
//

import UIKit
import SnapKit
import Then

extension MainViewController {
    func setupUI() {
        let titleLabel = UILabel().then {
            $0.text = "OpenWeatherMap"
            $0.font = .systemFont(ofSize: 32, weight: .bold)
            $0.textColor = .black
        }
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, searchBar, goButton]).then {
            $0.axis = .vertical
            $0.spacing = 8
            $0.distribution = .equalSpacing
            $0.alignment = .center
        }
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.equalTo(24)
            $0.right.equalTo(-24)
        }
        
        searchBar.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
        
        goButton.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
    }
}
