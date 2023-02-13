//
//  ViewController+UI.swift
//  RxWeather
//
//  Created by dwKang on 2023-02-13.
//

import UIKit
import SnapKit

extension ViewController {
    func setupUI() {
        view.addSubview(countryLabel)
        countryLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(100)
        }
        
        view.addSubview(cityNameLabel)
        cityNameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(countryLabel.snp.bottom).offset(24)
        }
        
        view.addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.size.equalTo(80)
            $0.top.equalTo(cityNameLabel.snp.bottom).offset(24)
        }
        
        iconView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(weatherLabel)
        weatherLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(iconImageView.snp.bottom).offset(24)
        }
        
        view.addSubview(tempLabel)
        tempLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(weatherLabel.snp.bottom).offset(24)
        }
        
        view.addSubview(feelsLikeTempLabel)
        feelsLikeTempLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(tempLabel.snp.bottom).offset(24)
        }
        
        // Test value for preview
//        countryLabel.text = "JP"
//        cityNameLabel.text = "Tokyo"
//        weatherLabel.text = "Rain"
//        tempLabel.text = "7.0 °C"
//        feelsLikeTempLabel.text = "Feels Like 2.4 °C"
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct ViewControllerPreview: PreviewProvider {

    static var previews: some View {
        // view controller using programmatic UI
        ViewController().toPreview()
    }
}
#endif
