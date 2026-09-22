//
// RouteComposer
// ProductViewController.swift
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

struct ProductContext {

    let productID: String

    let productURL: URL?

    init(productID: String, productURL: URL? = nil) {
        self.productID = productID
        self.productURL = productURL
    }
}

class ProductViewController: UIViewController, ExampleAnalyticsSupport, ContextAccepting {

    let screenType: ExampleScreenTypes = .product

    typealias Model = String

    private(set) var productID: Model? {
        didSet {
            reloadData()
        }
    }

    @IBOutlet private var productIDLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()

        if navigationController?.viewControllers.count == 1 {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        }
    }

    func setup(with context: ProductContext) throws {
        productID = context.productID
    }

    class func checkCompatibility(with context: Context) throws {
        if context.productID.isEmpty {
            throw RoutingError.generic(.init("ProductId can not be empty."))
        }
    }

    @objc func doneTapped() {
        dismiss(animated: true)
    }

    private func reloadData() {
        guard isViewLoaded else {
            return
        }

        productIDLabel.text = productID
        if let productID {
            view.accessibilityIdentifier = "productViewController+\(productID)"
            title = "Product \(productID)"
        } else {
            view.accessibilityIdentifier = "productViewController"
            title = "Product"
        }
    }

    @IBAction func goToCircleTapped() {
        try? router.navigate(to: ConfigurationHolder.configuration.circleScreen, with: nil)
    }

    @IBAction func goToSplitTapped() {
        try? router.navigate(to: CitiesConfiguration.citiesList())
    }

    @IBAction func goToProductTapped() {
        try? router.navigate(to: ProductConfiguration.productScreen, with: ProductContext(productID: "01"))
    }

    @IBAction func goToSwiftUITapped() {
        try? router.navigate(to: ConfigurationHolder.configuration.swiftUIScreen, with: "RouteComposer")
    }

    @IBAction func goToProductFromCircleTapped() {
        guard let productID,
              var productIDAsInt = Int(productID) else {
            return
        }
        productIDAsInt = productIDAsInt < 9 ? productIDAsInt + 1 : 0
        try? router.navigate(to: ProductConfiguration.productScreenFromCircle, with: ProductContext(productID: "0\(productIDAsInt)"))
    }

    @IBAction func goHome() {
        try? router.navigate(to: InternalSearchConfiguration.home)
    }

    @IBAction func goSettings() {
        try? router.navigate(to: InternalSearchConfiguration.settings)
    }

}

extension ProductViewController: ContextChecking {

    func isTarget(for context: ProductContext) -> Bool {
        productID == context.productID
    }

}
