//
// Created by Banghua Zhao on 30/08/2024
// Copyright Apps Bay Limited. All rights reserved.
//

import SwiftUI

struct SimpleMessageView: View {
    let message: String

    var body: some View {
        Text(message)
            .padding()
            .background(Color.black.opacity(0.7))
            .foregroundColor(.white)
            .cornerRadius(20)
            .shadow(radius: 10)
    }
}
