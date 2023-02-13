//
//  ViewReactor.swift
//  RxWeather
//
//  Created by dwKang on 2023-02-13.
//

import ReactorKit
import RxSwift
import RxCocoa

final class ViewReactor: Reactor {
    enum Action {
        case fetchWeather(String)
    }
    
    enum Mutation {
        case fetchWeather(WeatherResponse)
        case weatherError(WeatherError)
    }
    
    struct State {
        var weatherResponse: WeatherResponse? = nil
        var weatherError: WeatherError? = nil
    }
    
    var service: WeatherServiceType
    var initialState = State()
    
    init(service: WeatherServiceType) {
        self.service = service
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchWeather(let cityName):
            return service.fetchWeather(cityName: cityName)
                .map { result in
                    switch result {
                    case .success(let res):
                        return .fetchWeather(res!)
                    case .failure(let error):
                        return .weatherError(error)
                    }
                }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .fetchWeather(let res):
            state.weatherResponse = res
        case .weatherError(let error):
            state.weatherError = error
        }
        return state
    }
}
