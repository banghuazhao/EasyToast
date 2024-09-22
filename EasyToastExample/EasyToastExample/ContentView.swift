//
// Created by Banghua Zhao on 30/08/2024
// Copyright Apps Bay Limited. All rights reserved.
//

import EasyToast
import SwiftUI

struct ContentView: View {
    @State var showToast: Bool = false
    @State var showDefaultToastOnTop: Bool = false
    @State var showDefaultToastOnCenter: Bool = false
    @State var showDefaultToastOnBottom: Bool = false
    @State var showCustomToastStyle1: Bool = false
    @State var showCustomToastStyle2: Bool = false
    @State var showCustomToastStyle3: Bool = false
    @State var showToastTypeSuccess: Bool = false
    @State var showCustomToastView: Bool = false

    var body: some View {
        List {
            Button("Default Toast") {
                showToast = true
            }
            Button("Default Toast on Top") {
                showDefaultToastOnTop = true
            }
            Button("Default Toast on Center") {
                showDefaultToastOnCenter = true
            }
            Button("Default Toast on Bottom") {
                showDefaultToastOnBottom = true
            }
            Button("Custom Toast Style 1: background and text color") {
                showCustomToastStyle1 = true
            }
            Button("Custom Toast Style 2: font, corner radius and padding") {
                showCustomToastStyle2 = true
            }
            Button("Custom Toast Style 3: shadow and text alignment") {
                showCustomToastStyle3 = true
            }
            Button("Toast Type Success") {
                showToastTypeSuccess = true
            }
            Button("Custom Toast View") {
                showCustomToastView = true
            }
        }
        .easyToast(isPresented: $showToast, message: "Default Toast")
        .easyToast(isPresented: $showDefaultToastOnTop, message: "Default Toast on Top", position: .top)
        .easyToast(isPresented: $showDefaultToastOnCenter, message: "Default Toast on Center", position: .center)
        .easyToast(isPresented: $showDefaultToastOnBottom, message: "Default Toast on Bottom", position: .bottom)
        .easyToast(
            isPresented: $showCustomToastStyle1,
            message: "Custom Toast Style 1",
            style: ToastStyle(
                backgroundColor: .blue,
                textColor: .white
            )
        )
        .easyToast(
            isPresented: $showCustomToastStyle2,
            message: "Custom Toast Style 2",
            style: ToastStyle(
                font: .system(size: 20),
                cornerRadius: 20,
                padding: .init(top: 10, leading: 20, bottom: 10, trailing: 20)
            )
        )
        .easyToast(
            isPresented: $showCustomToastStyle3,
            message: "Custom Toast Style 3: shadow and text alignment and more text for test",
            style: ToastStyle(
                shadow: .gray,
                multilineTextAlignment: .leading
            )
        )
        .easyToast(
            isPresented: $showToastTypeSuccess,
            message: "Operation Successful",
            type: .success
        )
        .customToast(isPresented: $showCustomToastView) {
            HStack {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.white)
                Text("Show Toast Success")
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.green)
            .cornerRadius(20)
        }
    }
}

#Preview {
    ContentView()
}
