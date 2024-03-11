//
//  WeatherViewModelTests.swift
//  City WeatherTests
//
//  Created by Usman.Kulaha on 10/03/2024.
//

import XCTest
@testable import City_Weather

final class WeatherViewModelTests: XCTestCase {
	var viewModel: WeatherViewModel!
	var mockRepository: MockWeatherRepository!
	var mockAPIService: MockWeatherAPIService!

	override func setUpWithError() throws {
		mockAPIService = MockWeatherAPIService()
		mockRepository = MockWeatherRepository(weatherService: mockAPIService)
		viewModel = WeatherViewModel(weatherRepository: mockRepository)
	}

	override func tearDownWithError() throws {
		mockRepository = nil
		viewModel = nil
		mockAPIService = nil
	}

	func testGetCurrentWeather() throws {
		let city = "New York"
		let expectedWeatherInfo = WeatherInfo(cityName: "New York, US", temperature: "-253.15 °C", weatherDescription: "Cloudy")
		
		mockRepository.mockWeatherResponse = WeatherResponse(coord: Coord(lon: 0, lat: 0), weather: [Weather(id: 1, main: "Clouds", description: "Cloudy", icon: "")], base: "", main: Main(temp: 20.0, feels_like: 0, temp_min: 0, temp_max: 0, pressure: 0, humidity: 0, sea_level: 0, grnd_level: 0), visibility: 0, wind: Wind(speed: 0, deg: 0, gust: 0), clouds: Clouds(all: 0), dt: 0, sys: Sys(country: "US", sunrise: Date(), sunset: Date()), timezone: 0, id: 0, name: "New York", cod: 200)

		let expectation = self.expectation(description: "Completion handler invoked")

		viewModel.getCurrentWeather(for: city) { weatherInfo in
			XCTAssertEqual(weatherInfo, expectedWeatherInfo)
			expectation.fulfill()
		}

		waitForExpectations(timeout: 1, handler: nil)
	}

}
