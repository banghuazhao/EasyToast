//
// Created by Banghua Zhao on 06/10/2024
// Copyright Apps Bay Limited. All rights reserved.
//

import SwiftUI

public enum ToastAnimation {
    case fade
    case slide(Edge)
    case scale
    case custom(AnyTransition)
}

extension ToastAnimation {
    var transition: AnyTransition {
        switch self {
        case .fade:
            return .opacity
        case .scale:
            return .scale
        case let .slide(direction):
            switch direction {
            case .top:
                return .move(edge: .top).combined(with: .opacity)
            case .bottom:
                return .move(edge: .bottom).combined(with: .opacity)
            case .leading:
                return .move(edge: .leading).combined(with: .opacity)
            case .trailing:
                return .move(edge: .trailing).combined(with: .opacity)
            }
        case let .custom(customTransition):
            return customTransition
        }
    }
}
