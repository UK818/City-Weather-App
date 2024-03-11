//
//  MockRepository.swift
//  City Weather
//
//  Created by Usman.Kulaha on 10/03/2024.
//

class MockWeatherRepository: WeatherRepository {
	private let weatherService: WeatherService

	init(weatherService: WeatherService) {
		self.weatherService = weatherService
	}

	var mockWeatherResponse: WeatherResponse?
	var mockError: Error?

	func getCurrentWeather(for city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
		if let response = mockWeatherResponse {
			completion(.success(response))
		} else if let error = mockError {
			completion(.failure(error))
		} else {
			completion(.failure(MockError.noData))
		}
	}
}
