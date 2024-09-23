//
// Created by Banghua Zhao on 23/09/2024
// Copyright Apps Bay Limited. All rights reserved.
//
  
import SwiftUI

public struct ToastStyle {
    public var backgroundColor: Color
    public var textColor: Color
    public var font: Font
    public var cornerRadius: CGFloat
    public var shadow: Color
    public var padding: EdgeInsets
    public var multilineTextAlignment: TextAlignment

    public init(
        backgroundColor: Color = Color.black.opacity(0.8),
        textColor: Color = .white,
        font: Font = .system(size: 14),
        cornerRadius: CGFloat = 8,
        shadow: Color = .clear,
        padding: EdgeInsets = EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12),
        multilineTextAlignment: TextAlignment = .leading
    ) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.font = font
        self.cornerRadius = cornerRadius
        self.shadow = shadow
        self.padding = padding
        self.multilineTextAlignment = multilineTextAlignment
    }
}
