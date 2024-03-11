//
//  DIContainer.swift
//  City Weather
//
//  Created by Usman.Kulaha on 10/03/2024.
//

import Foundation

import Foundation

class DIContainer {
	static let shared = DIContainer()
	
	private let weatherService: WeatherService
	private let weatherRepository: WeatherRepository
	private let weatherViewModel: WeatherViewModel
	private let weatherViewCoordinator: WeatherViewCoordinator
	
	private init() {
		weatherService = OpenWeatherService()
		weatherRepository = WeatherRepositoryImpl(weatherService: weatherService)
		weatherViewModel = WeatherViewModel(weatherRepository: weatherRepository)
		weatherViewCoordinator = WeatherViewCoordinator(viewModel: weatherViewModel)
	}
	
	func getWeatherViewModel() -> WeatherViewModel {
		return weatherViewModel
	}
	
	func getWeatherViewCoordinator() -> WeatherViewCoordinator {
		return weatherViewCoordinator
	}
	
	
}
