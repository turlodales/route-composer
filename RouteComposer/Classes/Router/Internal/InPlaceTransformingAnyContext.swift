//
// RouteComposer
// InPlaceTransformingAnyContext.swift
// https://github.com/ekazaev/route-composer
//
// Created by Eugene Kazaev in 2018-2026.
// Distributed under the MIT license.
//
// Become a sponsor:
// https://github.com/sponsors/ekazaev
//

import Foundation

struct InPlaceTransformingAnyContext: AnyContext {
    let context: AnyContext
    let transformer: AnyContextTransformer

    func value<Context>() throws -> Context {
        return try transformer.transform(context)
    }
}
