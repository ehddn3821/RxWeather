//
//  MainViewReactor.swift
//  RxWeather
//
//  Created by dwKang on 2023-02-15.
//

import ReactorKit

final class MainViewReactor: Reactor {
    
    enum Action {
        case inputText(String)
    }
    
    enum Mutation {
        case setSearchCities([String])
    }
    
    struct State {
        var searchResult: [String] = []
    }
    
    var initialState = State()
    var service: WeatherServiceType
    
    init(service: WeatherServiceType) {
        self.service = service
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .inputText(let text):
            return service.searchCity(text)
                .map { .setSearchCities($0) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setSearchCities(let cities):
            newState.searchResult = cities
            return newState
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return self.currentState.searchResult.count
    }
    
    func cellForRowAt(_ cell: ResultTableViewCell, indexRow: Int) {
        cell.cityNameLabel.text = self.currentState.searchResult[indexRow]
    }
    
    func presentToWeatherViewController(from: BaseViewController, indexRow: Int) {
        let rct = WeatherViewReactor(service: self.service, cityName: self.currentState.searchResult[indexRow])
        let vc = WeatherViewController()
        vc.reactor = rct
        from.present(vc, animated: true)
    }
}
