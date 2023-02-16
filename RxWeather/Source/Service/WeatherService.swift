//
//  WeatherService.swift
//  RxWeather
//
//  Created by dwKang on 2023-02-13.
//

import Foundation
import Alamofire
import RxSwift

protocol WeatherServiceType {
    func searchCity(_ searchText: String) -> Observable<[String]>
    func fetchWeather(cityName: String) -> Observable<Result<WeatherResponse?, WeatherError>>
    func downloadIcon(_ iconName: String) -> Observable<UIImage>
}

final class WeatherService: WeatherServiceType {
    let baseUrl: String = "https://api.openweathermap.org/data/2.5/weather"
    var cities: [City] = []
    
    init() {
        Log.info("init")
        guard let path = Bundle.main.path(forResource: "CitiesList", ofType: "json") else { return }
        guard let jsonString = try? String(contentsOfFile: path) else { return }
        if let data = jsonString.data(using: .utf8),
           let cities = try? JSONDecoder().decode([City].self, from: data) {
            self.cities = cities
        }
    }
    
    func searchCity(_ searchText: String) -> Observable<[String]> {
        var result: [String] = []
        
        for city in cities {
            let cityName = city.name.lowercased()
            if cityName.hasPrefix(searchText) {
                result.append(cityName)
                if result.count == 5 {
                    return .just(result)
                }
            }
        }
        return .just(result)
    }
    
    func fetchWeather(cityName: String) -> Observable<Result<WeatherResponse?, WeatherError>> {
        return Observable.create { observer -> Disposable in
            AF.request(self.baseUrl,
                       method: .get,
                       parameters: ["q" : cityName,
                                    "appid" : APIKey.key,
                                    "units": "metric"])
            .responseDecodable(of: WeatherResponse.self) { response in
                switch response.result {
                case .success(let data):
                    observer.onNext(.success(data))
                case .failure(let error):
                    guard let data = response.data else { return observer.onError(error) }
                    let error = try! JSONDecoder().decode(WeatherError.self, from: data)
                    observer.onNext(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func downloadIcon(_ iconName: String) -> Observable<UIImage> {
        let url = "http://openweathermap.org/img/wn/\(iconName)@2x.png"
        return Observable.create { observer -> Disposable in
            AF.download(url).responseData { res in
                switch res.result {
                case .success(let data):
                    observer.onNext(UIImage(data: data)!)
                case .failure(let error):
                    Log.error(error.localizedDescription)
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
