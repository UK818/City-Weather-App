//
//  UserDefaultsHelper.swift
//  City Weather
//
//  Created by Usman.Kulaha on 10/03/2024.
//

import Foundation

class UserDefaultsHelper {
	private let key = "CachedCities"
	
	func getCachedCities() -> [String]? {
		if let cachedCitiesData = UserDefaults.standard.value(forKey: key) as? Data {
			let decoder = JSONDecoder()
			return try? decoder.decode([String].self, from: cachedCitiesData)
		}
		return nil
	}
	
	func saveCity(_ cityName: String) {
		var cachedCities = getCachedCities() ?? []
		
		if let index = cachedCities.firstIndex(of: cityName) {
			cachedCities.remove(at: index)
		}
		
		cachedCities.insert(cityName, at: 0)
		
		let encoder = JSONEncoder()
		if let encoded = try? encoder.encode(cachedCities) {
			UserDefaults.standard.set(encoded, forKey: key)
		}
	}

}
