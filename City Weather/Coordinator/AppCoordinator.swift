//
//  AppCoordinator.swift
//  City Weather
//
//  Created by Usman.Kulaha on 11/03/2024.
//

import Foundation
import UIKit

protocol Coordinator {
	func start()
}

class AppCoordinator: Coordinator {
	private let navigationController: UINavigationController
	var diContainer: DIContainer?
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		diContainer = DIContainer.shared
	}
	
	func start() {
		let viewModel = diContainer?.getWeatherViewModel()
		let useDefaultsHelper = UserDefaultsHelper()

		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		guard let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? ViewController else {
		   fatalError("Unable to instantiate ViewController from storyboard")
		}

		viewController.viewModel = viewModel
		viewController.userDefaultsHelper = useDefaultsHelper
		viewController.coordinator = self
		navigationController.pushViewController(viewController, animated: true)
	}
	
	func showDetailsViewController() {
		let viewModel = diContainer?.getWeatherViewModel()
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		guard let viewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {
		   fatalError("Unable to instantiate ViewController from storyboard")
		}
		viewController.viewModel = viewModel
		navigationController.pushViewController(viewController, animated: true)
	}
}

