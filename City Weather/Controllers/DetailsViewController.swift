//
//  DetailsViewController.swift
//  City Weather
//
//  Created by Usman.Kulaha on 10/03/2024.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
	
	@IBOutlet weak var cityName: UILabel!
	@IBOutlet weak var currentTemperature: UILabel!
	@IBOutlet weak var minimumTemperature: UILabel!
	@IBOutlet weak var maximumTemperature: UILabel!
	@IBOutlet weak var pressure: UILabel!
	@IBOutlet weak var humidity: UILabel!
	@IBOutlet weak var feelsLike: UILabel!
	@IBOutlet weak var windSpeed: UILabel!
	@IBOutlet weak var sunrise: UILabel!
	@IBOutlet weak var sunset: UILabel!
	
	var viewModel: WeatherViewModel?
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		populateUI()
	}
	
	private func populateUI() {
		if let detailedInfo = viewModel?.getDetailedWeather() {
			cityName.text = detailedInfo.cityName
			currentTemperature.text = detailedInfo.temperature
			minimumTemperature.text = detailedInfo.minTemperature
			maximumTemperature.text = detailedInfo.maxTemperature
			pressure?.text = detailedInfo.pressure
			humidity.text = detailedInfo.humidity
			feelsLike.text = detailedInfo.feelsLike
			windSpeed.text = detailedInfo.windSpeed
			sunrise?.text = detailedInfo.sunriseTime
			sunset?.text = detailedInfo.sunsetTime
		}
	}
}
