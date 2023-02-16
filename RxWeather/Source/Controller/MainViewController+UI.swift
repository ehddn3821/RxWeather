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
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(0.9)
            $0.left.equalTo(24)
            $0.right.equalTo(-24)
        }
        
        searchBar.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
        
        self.view.addSubview(resultTableView)
        resultTableView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(16)
            $0.left.right.equalTo(stackView)
            $0.height.equalTo(0)
        }
    }
}
