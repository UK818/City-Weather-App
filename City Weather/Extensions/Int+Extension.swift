//
//  Int+Extension.swift
//  City Weather
//
//  Created by Usman.Kulaha on 10/03/2024.
//

import Foundation

extension Int {
	func toPressure() -> String {
		return "\(self)mmHg"
	}
	
	func toHumidity() -> String {
		return "\(self)%"
	}
}
