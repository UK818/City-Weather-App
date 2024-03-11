//
//  MockService.swift
//  City Weather
//
//  Created by Usman.KUlaha on 10/03/2024.
//

import Foundation

class MockWeatherAPIService: WeatherService {
	var mockWeatherData: Data?
	var mockError: Error?

	func fetch(for city: String?, completion: @escaping (Result<Data, Error>) -> Void) {
		if let data = mockWeatherData {
			completion(.success(data))
		} else if let error = mockError {
			completion(.failure(error))
		} else {
			completion(.failure(MockError.noData))
		}
	}
}
