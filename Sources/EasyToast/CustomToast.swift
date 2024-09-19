//
// Created by Banghua Zhao on 19/09/2024
// Copyright Apps Bay Limited. All rights reserved.
//
  

import SwiftUI

struct CustomToast<CustomView: View>: ViewModifier {
    @Binding var isPresented: Bool
    private let duration: Double
    private let position: ToastPosition
    let customView: CustomView

    init(
        isPresented: Binding<Bool>,
        position: ToastPosition,
        duration: Double,
        customView: CustomView
    ) {
        _isPresented = isPresented
        self.duration = duration
        self.position = position
        self.customView = customView
    }

    @State private var showToast: Bool = false

    public func body(content: Content) -> some View {
        content
            .overlay(alignment: alignment) {
                if showToast {
                    toast
                }
            }
            .onChange(of: isPresented) { newValue in
                if newValue == true {
                    withAnimation {
                        showToast = true
                    }
                    Task { @MainActor in
                        try? await Task.sleep(nanoseconds: UInt64(duration) * 1000000000)
                        withAnimation {
                            isPresented = false
                            showToast = false
                        }
                    }
                }
            }
    }

    @ViewBuilder
    private var toast: some View {
        switch position {
        case .top:
            toastView
                .transition(.move(edge: .top).combined(with: .opacity))
        case .center:
            toastView
                .transition(.opacity)
        case .bottom:
            toastView
                .transition(.move(edge: .bottom).combined(with: .opacity))
        }
    }

    @ViewBuilder
    private var toastView: some View {
        customView
    }

    private var alignment: Alignment {
        switch position {
        case .top:
            .top
        case .center:
            .center
        case .bottom:
            .bottom
        }
    }
}

public extension View {
    /**
     Displays a toast notification with a custom view.

     - Parameters:
        - isPresented: A binding to a boolean value that determines whether the toast is presented.
        - duration: The duration in seconds for which the toast is displayed. The default value is 2 seconds.
        - position: The position on the screen where the toast is displayed. The default is `.center`.
        - customView: A closure that returns the custom view to be displayed as the toast content.

     - Returns: A view that displays the original content overlaid with a custom toast view when `isPresented` is `true`.

     Use this method to present a custom-designed toast view. The toast will automatically disappear after the specified duration.

     - Note: The toast will only appear when `isPresented` is set to `true`.

     Example usage:
     ```swift
     Text("Hello, World!")
         .customToast(isPresented: $showToast, duration: 3, position: .bottom) {
             HStack {
                 Image(systemName: "checkmark.circle")
                     .foregroundColor(.white)
                 Text("Show Custom Toast Success")
                     .foregroundColor(.white)
             }
             .padding()
             .background(Color.green)
             .cornerRadius(20)
         }
     ```
     */
    func customToast(
        isPresented: Binding<Bool>,
        duration: Double = 2,
        position: ToastPosition = .center,
        @ViewBuilder customView: @escaping () -> some View
    ) -> some View {
        modifier(
            CustomToast(
                isPresented: isPresented,
                position: position,
                duration: duration,
                customView: customView()
            )
        )
    }
}
