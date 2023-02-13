//
//  Double+Celsius.swift
//  RxWeather
//
//  Created by dwKang on 2023-02-13.
//

import Foundation

extension Double {
    var toCelsiusString: String {
        return String(format: "%.1f", self) + " °C"
    }
}
