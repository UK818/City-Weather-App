//
//  WeatherRepository.swift
//  City Weather
//
//  Created by Usman.Kulaha on 10/03/2024.
//

import Foundation

protocol WeatherRepository {
	func getCurrentWeather(for city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void)
}

class WeatherRepositoryImpl: WeatherRepository {
	private let weatherService: WeatherService
	
	init(weatherService: WeatherService) {
		self.weatherService = weatherService
	}
	
	func getCurrentWeather(for city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
		weatherService.fetch(for: city) { result in
			switch result {
			case .success(let data):
				do {
					let response = try JSONDecoder().decode(WeatherResponse.self, from: data)
					print(response)
					completion(.success(response))
				} catch {
					completion(.failure(error))
				}
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
