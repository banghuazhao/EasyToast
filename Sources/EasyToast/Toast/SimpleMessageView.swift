//
// Created by Banghua Zhao on 30/08/2024
// Copyright Apps Bay Limited. All rights reserved.
//

import SwiftUI

struct SimpleMessageView: View {
    let message: String
    let style: ToastStyle

    var body: some View {
        Text(message)
            .font(style.font)
            .foregroundColor(style.textColor)
            .padding(style.padding)
            .background(style.backgroundColor)
            .cornerRadius(style.cornerRadius)
            .shadow(color: style.shadow, radius: 4)
            .multilineTextAlignment(style.multilineTextAlignment)
            .fixedSize(horizontal: false, vertical: true)
            .padding()
    }
}
