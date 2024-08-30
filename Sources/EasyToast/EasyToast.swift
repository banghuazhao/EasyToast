//
// Created by Banghua Zhao on 30/08/2024
// Copyright Apps Bay Limited. All rights reserved.
//

import SwiftUI

public enum ToastPosition {
    case top
    case center
    case bottom
}

struct EasyToast<CustomView: View>: ViewModifier {
    @Binding var isPresented: Bool
    private let message: String?
    private let duration: Double
    private let position: ToastPosition
    let customView: CustomView?

    init(
        isPresented: Binding<Bool>,
        message: String? = nil,
        position: ToastPosition,
        duration: Double,
        customView: CustomView? = nil
    ) {
        _isPresented = isPresented
        self.message = message
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
        if let customView {
            customView
        } else if let message {
            SimpleMessageView(message: message)
        } else {
            EmptyView()
        }
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
     Displays a simple toast notification with a text message.

     - Parameters:
        - isPresented: A binding to a boolean value that determines whether the toast is presented.
        - message: The message text to be displayed in the toast.
        - duration: The duration in seconds for which the toast is displayed. The default value is 2 seconds.
        - position: The position on the screen where the toast is displayed. The default is `.center`.

     - Returns: A view that displays the original content overlaid with a toast notification when `isPresented` is `true`.

     Use this method to present a brief message to the user. The toast will automatically disappear after the specified duration.

     - Note: The toast will only appear when `isPresented` is set to `true`.

     Example usage:
     ```swift
     Text("Hello, World!")
         .easyToast(isPresented: $showToast, message: "This is a toast message")
     ```
     */
    func easyToast(
        isPresented: Binding<Bool>,
        message: String,
        duration: Double = 2,
        position: ToastPosition = .center
    ) -> some View {
        modifier(
            EasyToast<EmptyView>(
                isPresented: isPresented,
                message: message,
                position: position,
                duration: duration
            )
        )
    }

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
         .easyToast(isPresented: $showToast, duration: 3, position: .bottom) {
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
    func easyToast(
        isPresented: Binding<Bool>,
        duration: Double = 2,
        position: ToastPosition = .center,
        @ViewBuilder customView: @escaping () -> some View
    ) -> some View {
        modifier(
            EasyToast(
                isPresented: isPresented,
                position: position,
                duration: duration,
                customView: customView()
            )
        )
    }
}
