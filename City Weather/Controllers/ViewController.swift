//
//  ViewController.swift
//  City Weather
//
//  Created by Usman.Kulaha on 10/03/2024.
//

import UIKit
import SVProgressHUD
import SwiftMessages

class ViewController: UIViewController {

	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var temperature: UILabel!
	@IBOutlet weak var weatherDescription: UILabel!
	@IBOutlet weak var City: UILabel!
	@IBOutlet weak var moreDetailsButton: UIButton!
	@IBOutlet weak var icon: UIImageView!
	
	var viewModel: WeatherViewModel?
	var coordinator: AppCoordinator?
	var userDefaultsHelper: UserDefaultsHelper?
	var cachedCities: [String] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupSearchBar()
		setupTableView()
		loadCachedCities()
		moreDetailsButton.isHidden = true
		moreDetailsButton.addTarget(self, action: #selector(showDetails), for: .touchUpInside)
	}
	
	func setupSearchBar() {
		searchBar?.delegate = self
	}
	
	func setupTableView() {
		tableView?.dataSource = self
		tableView?.delegate = self
		tableView?.isHidden = true
		icon.isHidden = false
		tableView.register(SearchBarCell.self, forCellReuseIdentifier: "Cell")
	}
	
	@objc func showDetails() {
		coordinator?.showDetailsViewController()
	}
	
	func loadCachedCities() {
		if let cities = userDefaultsHelper?.getCachedCities() {
			cachedCities = cities
			if let lastCity = cities.last {
				searchBar?.text = lastCity
			}
		}
	}
	
	func handleCitySearch(city: String) {
		userDefaultsHelper?.saveCity(city)
		searchBar.resignFirstResponder()
		SVProgressHUD.show()
		weatherDescription.isHidden = true
		viewModel?.getCurrentWeather(for: city) { [weak self] weatherInfo in
			DispatchQueue.main.async {
				SVProgressHUD.dismiss()
				self?.weatherDescription.isHidden = false
				if let weatherInfo = weatherInfo {
					self?.updateUI(with: weatherInfo)
				} else {
					self?.showErrorMessage("Failed to fetch weather for \(city)")
				}
			}
		}
	}
	
}

extension ViewController: UISearchBarDelegate {
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		tableView?.isHidden = false
		icon.isHidden = true
		tableView?.reloadData()
	}
	
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		tableView?.isHidden = true
		icon.isHidden = false
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let city = searchBar.text, !city.isEmpty else {
			return
		}
		handleCitySearch(city: city)
		
	}

	private func updateUI(with weatherInfo: WeatherInfo) {
		temperature.text = weatherInfo.temperature
		weatherDescription.text = weatherInfo.weatherDescription
		City.text = weatherInfo.cityName
		moreDetailsButton.isHidden = false
	}

	private func showErrorMessage(_ message: String) {
			print("Error: \(message)")
			let view = MessageView.viewFromNib(layout: .cardView)
			view.configureTheme(.error)
			view.configureDropShadow()
			view.configureContent(title: "Error", body: message)
			var config = SwiftMessages.defaultConfig
			config.presentationStyle = .top
			config.presentationContext = .window(windowLevel: .statusBar)
			SwiftMessages.show(config: config, view: view)
		}
}

extension ViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		searchBar?.text = cachedCities[indexPath.row]
		tableView.isHidden = true
		icon.isHidden = false
		searchBar?.resignFirstResponder()
		handleCitySearch(city: cachedCities[indexPath.row])
	}
}

extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cachedCities.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SearchBarCell else { return UITableViewCell()}
		cell.textLabel?.text = cachedCities[indexPath.row]
		return cell
	}
}

