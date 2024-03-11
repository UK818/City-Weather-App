//
//  CurrentWeatherModel.swift
//  City Weather
//
//  Created by Usman Kulaha on 10/03/2024.
//

import Foundation

struct WeatherResponse: Codable {
	let coord: Coord?
	let weather: [Weather]?
	let base: String?
	let main: Main?
	let visibility: Int?
	let wind: Wind?
	let clouds: Clouds?
	let dt: Int?
	let sys: Sys?
	let timezone: Int?
	let id: Int?
	let name: String?
	let cod: Int?
}

struct Coord: Codable {
	let lon: Double?
	let lat: Double?
}

struct Weather: Codable {
	let id: Int?
	let main: String?
	let description: String?
	let icon: String?
}

struct Main: Codable {
	let temp: Double?
	let feels_like: Double?
	let temp_min: Double?
	let temp_max: Double?
	let pressure: Int?
	let humidity: Int?
	let sea_level: Int?
	let grnd_level: Int?
}

struct Wind: Codable {
	let speed: Double?
	let deg: Int?
	let gust: Double?
}

struct Clouds: Codable {
	let all: Int?
}

struct Sys: Codable {
	let country: String?
	let sunrise: Date?
	let sunset: Date?
}

struct WeatherInfo: Equatable {
	let cityName: String
	let temperature: String
	let weatherDescription: String
}

struct DetailedWeatherInfo: Equatable {
	let cityName: String
	let temperature: String
	let feelsLike: String
	let minTemperature: String
	let maxTemperature: String
	let pressure: String
	let humidity: String
	let windSpeed: String
	let sunriseTime: String
	let sunsetTime: String
}

extension WeatherResponse {
	func toWeatherInfo() -> WeatherInfo {
		let cityName = "\(name ?? ""), \(sys?.country ?? "")"
		let temperatureCelsius = main?.temp?.kelvinToCelsius() ?? ""
		let weatherDescription = weather?.first?.description ?? ""
		return WeatherInfo(cityName: cityName, temperature: temperatureCelsius, weatherDescription: weatherDescription)
	}
	
	func toDetailedWeatherInfo() -> DetailedWeatherInfo {
		let cityName = "\(name ?? ""), \(sys?.country ?? "")"
		let temperatureCelsius = main?.temp?.kelvinToCelsius() ?? ""
		let feelsLikeCelsius = main?.feels_like?.kelvinToCelsius() ?? ""
		let minTemperatureCelsius = main?.temp_min?.kelvinToCelsius() ?? ""
		let maxTemperatureCelsius = main?.temp_max?.kelvinToCelsius() ?? ""
		let pressure = (main?.pressure ?? 0).toPressure()
		let humidity = main?.humidity?.toHumidity() ?? ""
		let windSpeed = wind?.speed?.toSpeed() ?? ""
		let sunriseTime = (sys?.sunrise ?? Date()).toString24HourFormat() ?? ""
		let sunsetTime = (sys?.sunset ?? Date()).toString24HourFormat() ?? ""
		return DetailedWeatherInfo(cityName: cityName, temperature: temperatureCelsius, feelsLike: feelsLikeCelsius, minTemperature: minTemperatureCelsius, maxTemperature: maxTemperatureCelsius, pressure: pressure, humidity: humidity, windSpeed: windSpeed, sunriseTime: sunriseTime, sunsetTime: sunsetTime)
	}
}
