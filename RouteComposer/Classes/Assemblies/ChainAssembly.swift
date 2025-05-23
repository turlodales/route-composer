//
// RouteComposer
// ChainAssembly.swift
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

/// Builds a chain of steps.
@MainActor
public enum ChainAssembly {

    // MARK: Methods

    /// Transforms step into a chain of steps.
    /// ### Usage
    /// ```swift
    /// let intermediateStep = ChainAssembly.from(NavigationControllerStep<UINavigationController, Any?>())
    ///         .using(GeneralAction.presentModally())
    ///         .from(GeneralStep.current())
    ///         .assemble()
    /// ```
    /// - Parameter step: The instance of `ActionConnectingAssembly`
    @MainActor
    public static func from<VC: UIViewController, C>(_ step: ActionToStepIntegrator<VC, C>) -> ActionConnectingAssembly<VC, C> {
        ActionConnectingAssembly<VC, C>(stepToFullFill: step, previousSteps: [])
    }

}
