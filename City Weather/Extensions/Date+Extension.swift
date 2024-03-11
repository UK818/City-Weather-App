
//  Date+Extension.swift
//  City Weather
//
//  Created by Usman.Kulaha on 10/03/2024.
//

import Foundation

extension Date {
	func toString24HourFormat() -> String {
		let dateFormatter = DateFormatter()
		
		dateFormatter.dateFormat = "HH:mm"
		
		return dateFormatter.string(from: self)
	}
}
