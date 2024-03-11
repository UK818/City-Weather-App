//
//  Double+Extension.swift
//  City Weather
//
//  Created by Usman.Kulaha on 10/03/2024.
//

import Foundation

extension Double {
	func rounded(toPlaces places: Int) -> Double {
		let divisor = pow(10.0, Double(places))
		return (self * divisor).rounded() / divisor
	}
	
	func kelvinToCelsius() -> String {
			let celsius = self - 273.15
			return "\(celsius.rounded(toPlaces: 2)) °C"
		}
	
	func toCelcius() -> String {
		return "\(self) °C"
	}
	
	func toSpeed() -> String {
		return "\(self)m/s"
	}
}
