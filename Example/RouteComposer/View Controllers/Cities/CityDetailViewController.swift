//
// RouteComposer
// CityDetailViewController.swift
// https://github.com/ekazaev/route-composer
//
// Created by Eugene Kazaev in 2018-2026.
// Distributed under the MIT license.
//
// Become a sponsor:
// https://github.com/sponsors/ekazaev
//

import Foundation
import RouteComposer
import UIKit

class CityDetailContextTask: ContextTask {

    func perform(on viewController: CityDetailViewController, with context: Int) throws {
        viewController.cityID = context
    }

}

class CityDetailViewController: UIViewController, ExampleAnalyticsSupport {

    let screenType: ExampleScreenTypes = .cityDetail

    @IBOutlet private var detailsTextView: UITextView!

    var cityID: Int? {
        didSet {
            reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }

    private func reloadData() {
        guard isViewLoaded, let city = CitiesDataModel.cities.first(where: { $0.cityID == cityID }) else {
            return
        }
        title = "\(city.city)"

        detailsTextView.text = city.city + "\n\n" + city.description
        if let cityID {
            view.accessibilityIdentifier = "cityDetailsViewController+\(cityID)"
        } else {
            view.accessibilityIdentifier = "cityDetailsViewController"
        }
    }

    @IBAction func goToStarTapped() {
        try? router.navigate(to: ConfigurationHolder.configuration.starScreen, with: "Test Context")
    }

    @IBAction func backProgrammaticallyTapped() {
        try? router.navigate(to: CitiesConfiguration.citiesList(cityID: nil))
    }

}
