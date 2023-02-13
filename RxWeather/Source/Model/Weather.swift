//
//  Weather.swift
//  RxWeather
//
//  Created by dwKang on 2023-02-13.
//

import Foundation

struct WeatherResponse: Decodable {
    let weather: [Weather]
    let main: Temp
}

struct Temp: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
}

struct Weather: Decodable {
    let main: String
    let description: String
    let icon: String
}

struct WeatherError: Decodable, Error {
    let cod: String
    let message: String
}
