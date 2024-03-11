//
//  NetworkService.swift
//  City Weather
//
//  Created by Usman.Kulaha on 10/03/2024.
//

import Foundation


protocol WeatherService {
	func fetch(for query: String?, completion: @escaping (Result<Data, Error>) -> Void)
}

class OpenWeatherService: WeatherService {
	private let apiKey: String
	private let baseUrl: String
	
	init() {
		self.apiKey = "25fa0decdf5b5508bafca6bcbd56b062"
		self.baseUrl = "https://api.openweathermap.org/data/2.5/"
	}

	func fetch(for query: String?, completion: @escaping (Result<Data, Error>) -> Void) {
		let trimmedQuery = query?.trimmingCharacters(in: .whitespaces) ?? ""
		let encodedQuery = trimmedQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
		let urlString = "\(baseUrl)weather?q=\(encodedQuery)&appid=\(apiKey)"
		guard let url = URL(string: urlString) else {
			completion(.failure(ApiError.invalidUrl))
			return
		}
		
		URLSession.shared.dataTask(with: url) { data, response, error in
			print(data)
			print(response)
			if let error = error {
				completion(.failure(error))
				return
			}
			
			guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
				completion(.failure(ApiError.invalidResponse))
				return
			}
			
			guard let data = data else {
				completion(.failure(ApiError.invalidData))
				return
			}
			
			completion(.success(data))
		}.resume()
	}
}



enum ApiError: Error {
	case invalidUrl
	case invalidResponse
	case invalidData
}
