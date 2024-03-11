//
//  WeatherViewModel.swift
//  City Weather
//
//  Created by Usman.Kulaha on 10/03/2024.
//

import Foundation

class WeatherViewModel {
	private let weatherRepository: WeatherRepository
	var weatherResponse: WeatherResponse?
	
	init(weatherRepository: WeatherRepository) {
		self.weatherRepository = weatherRepository
	}
	
	func getCurrentWeather(for city: String, completion: @escaping (WeatherInfo?) -> Void) {
		weatherRepository.getCurrentWeather(for: city) { result in
			switch result {
			case .success(let weatherResponse):
				self.weatherResponse = weatherResponse
				let weatherInfo = weatherResponse.toWeatherInfo()
				completion(weatherInfo)
			case .failure(let error):
				print(error.localizedDescription)
				completion(nil)
			}
		}
	}
	
//	func getDetailedWeather(for city: String, completion: @escaping (DetailedWeatherInfo?) -> Void) {
//		weatherRepository.getCurrentWeather(for: city) { result in
//			switch result {
//			case .success(let weatherResponse):
//				let detailedWeatherInfo = weatherResponse.toDetailedWeatherInfo()
//				completion(detailedWeatherInfo)
//			case .failure(let error):
//				print(error.localizedDescription)
//				completion(nil)
//			}
//		}
//	}
	
	func getDetailedWeather() -> DetailedWeatherInfo? {
		return weatherResponse?.toDetailedWeatherInfo()
	}
}

class WeatherViewCoordinator {
	private let viewModel: WeatherViewModel
	
	init(viewModel: WeatherViewModel) {
		self.viewModel = viewModel
	}
	
	func fetchCurrentWeather(for city: String, completion: @escaping (WeatherInfo?) -> Void) {
		viewModel.getCurrentWeather(for: city, completion: completion)
	}
	
	func fetchDetailedWeather(for city: String, completion: @escaping (DetailedWeatherInfo?) -> Void) {
//		viewModel.getDetailedWeather(for: city, completion: completion)
	}
}
