//
//  WeatherService.swift
//  RxWeather
//
//  Created by dwKang on 2023-02-13.
//

import Alamofire
import RxSwift

protocol WeatherServiceType {
    func fetchWeather(cityName: String) -> Observable<Result<WeatherResponse?, WeatherError>>
    func downloadIcon(_ iconName: String) -> Observable<UIImage>
}

final class WeatherService: WeatherServiceType {
    let baseUrl: String = "https://api.openweathermap.org/data/2.5/weather"
    
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
