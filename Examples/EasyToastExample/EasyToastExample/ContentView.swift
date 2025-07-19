//
// Created by Banghua Zhao on 30/08/2024
// Copyright Apps Bay Limited. All rights reserved.
//

import EasyToast
import SwiftUI

struct ContentView: View {
    @State var showToast: Bool = false
    @State var showDefaultToastOnTop: Bool = false
    @State var showCustomToastStyle1: Bool = false
    @State var showCustomToastStyle2: Bool = false
    @State var showCustomToastStyle3: Bool = false
    @State var showToastTypeSuccess: Bool = false
    @State var showOnTapToastView: Bool = false
    @State var showSlideAnimationToastView: Bool = false
    @State var showScaleAnimationToastView: Bool = false
    @State var selectedCustomToast: String? = nil // For item-based toast example
    @State var selectedGradientToast: String? = nil
    @State var selectedActionToast: String? = nil

    var body: some View {
        List {
            Button("Default Toast") {
                showToast = true
            }
            Button("Default Toast on Top") {
                showDefaultToastOnTop = true
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
            Button("Tap toast example") {
                showOnTapToastView = true
            }
            Button("Slide from top animation toast example") {
                showSlideAnimationToastView = true
            }
            Button("Scale animation toast example") {
                showScaleAnimationToastView = true
            }
            Button("Custom Toast View (item-based)") {
                selectedCustomToast = "Show Toast Success"
            }
            Button("Gradient Toast") {
                selectedGradientToast = "Gradient Toast!"
            }
            Button("Toast with Action") {
                selectedActionToast = "Tap to Undo"
            }
        }
        .toast(isPresented: $showToast, message: "Default Toast")
        .toast(isPresented: $showDefaultToastOnTop, message: "Default Toast on Top", position: .top)
        .toast(
            isPresented: $showCustomToastStyle1,
            message: "Custom Toast Style 1",
            style: ToastStyle(
                backgroundColor: .blue,
                textColor: .white
            )
        )
        .toast(
            isPresented: $showCustomToastStyle2,
            message: "Custom Toast Style 2",
            style: ToastStyle(
                font: .system(size: 20),
                cornerRadius: 20,
                padding: .init(top: 10, leading: 20, bottom: 10, trailing: 20)
            )
        )
        .toast(
            isPresented: $showCustomToastStyle3,
            message: "Custom Toast Style 3: shadow and text alignment and more text for test",
            style: ToastStyle(
                shadow: .gray,
                multilineTextAlignment: .leading
            )
        )
        .toast(
            isPresented: $showToastTypeSuccess,
            message: "Operation Successful",
            type: .success
        )
        .toast(isPresented: $showOnTapToastView, message: "Tap toast example", duration: 5) {
            withAnimation {
                showOnTapToastView = false
            }
        }
        .toast(
            isPresented: $showSlideAnimationToastView,
            message: "Slide from top animation toast example",
            animation: .slide(.top)
        )
        .toast(
            isPresented: $showScaleAnimationToastView,
            message: "Scale animation toast example",
            animation: .scale
        )
        // Example of the new item-based toast API
        .toast(item: $selectedCustomToast) { value in
            HStack {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.white)
                Text(value)
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.green)
            .cornerRadius(20)
        }
        .toast(item: $selectedGradientToast) { value in
            HStack {
                Image(systemName: "flame.fill")
                    .foregroundColor(.white)
                Text(value)
                    .foregroundColor(.white)
            }
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.purple, .blue]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(20)
        }
        .toast(item: $selectedActionToast, duration: 5) {
            selectedActionToast = nil
        } content: { value in
            HStack {
                Image(systemName: "arrow.uturn.left")
                    .foregroundColor(.white)
                Text(value)
                    .foregroundColor(.white)
                Spacer()
                Text("Undo")
                    .bold()
                    .foregroundColor(.yellow)
            }
            .padding()
            .background(Color.orange)
            .cornerRadius(20)
        }
    }
}

#Preview {
    ContentView()
}
