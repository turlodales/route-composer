//
// RouteComposer
// Array+Extension.swift
// https://github.com/ekazaev/route-composer
//
// Created by Eugene Kazaev in 2018-2025.
// Distributed under the MIT license.
//
// Become a sponsor:
// https://github.com/sponsors/ekazaev
//

import Foundation
import UIKit

/// - Extension of an `Array` of the `UIViewControllers` is to check if all of them can be dismissed.
@MainActor
public extension Array where Element: UIViewController {

    /// Returns `true` if all `UIViewController` instances can be dismissed.
    var canBeDismissed: Bool {
        nonDismissibleViewController == nil
    }

}
