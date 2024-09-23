//
// Created by Banghua Zhao on 30/08/2024
// Copyright Apps Bay Limited. All rights reserved.
//

import SwiftUI

struct EasyToast: ViewModifier {
    @Binding var isPresented: Bool
    private let message: String
    private let duration: Double
    private let position: ToastPosition
    private let style: ToastStyle

    init(
        isPresented: Binding<Bool>,
        message: String,
        duration: TimeInterval,
        position: ToastPosition,
        style: ToastStyle = ToastStyle()
    ) {
        _isPresented = isPresented
        self.message = message
        self.duration = duration
        self.position = position
        self.style = style
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
        SimpleMessageView(message: message, style: style)
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
        position: ToastPosition = .center,
        style: ToastStyle = ToastStyle()
    ) -> some View {
        modifier(
            EasyToast(
                isPresented: isPresented,
                message: message,
                duration: duration,
                position: position,
                style: style
            )
        )
    }

    /**
     Displays a toast notification with a text message.

     - Parameters:
        - isPresented: A binding to a boolean value that determines whether the toast is presented. Set this to `true` to show the toast, and the toast will automatically disappear after the specified duration.
        - message: The message text to be displayed in the toast. This is a `String` value and will be the content of the toast notification.
        - duration: The duration in seconds for which the toast is displayed. The default value is 2 seconds. After this time has passed, the toast will automatically disappear.
        - position: The position on the screen where the toast is displayed. This can be `.top`, `.center`, or `.bottom`. The default is `.center`.
        - type: The type of toast to display. This can be `.success`, `.error`, `.warning`, or `.info`. The type determines the default appearance of the toast. The default is `.info`.

     - Returns: A view that displays the original content overlaid with a toast notification when `isPresented` is `true`.

     Use this method to present brief notifications to the user, such as success messages, error alerts, or warnings. The toast will automatically disappear after the specified duration.

     Example usage:
     ```swift
     Text("Hello, World!")
         .easyToast(isPresented: $showToast, message: "Operation Successful", type: .success)
     ```
     **/
    func easyToast(
        isPresented: Binding<Bool>,
        message: String,
        duration: Double = 2,
        position: ToastPosition = .center,
        type: ToastType
    ) -> some View {
        modifier(
            EasyToast(
                isPresented: isPresented,
                message: message,
                duration: duration,
                position: position,
                style: type.style
            )
        )
    }
}