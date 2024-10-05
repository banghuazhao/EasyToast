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
    private let animation: ToastAnimation
    private let onTap: (() -> Void)?

    @State private var showToast: Bool = false
    @State private var dismissToastTask: Task<Void, Never>?

    init(
        isPresented: Binding<Bool>,
        message: String,
        duration: TimeInterval,
        position: ToastPosition,
        style: ToastStyle,
        animation: ToastAnimation,
        onTap: (() -> Void)? = nil
    ) {
        _isPresented = isPresented
        self.message = message
        self.duration = duration
        self.position = position
        self.style = style
        self.animation = animation
        self.onTap = onTap
    }

    public func body(content: Content) -> some View {
        content
            .overlay(alignment: alignment) {
                if showToast {
                    toastView
                        .onTapGesture {
                            onTap?()
                        }
                }
            }
            .onChange(of: isPresented) { newValue in
                if newValue == true {
                    withAnimation {
                        showToast = true
                    }
                    cancelDismissToastTask() // Cancel the existing task if it exists
                    dismissToastTask = Task { @MainActor in
                        try? await Task.sleep(nanoseconds: UInt64(duration) * 1000000000)
                        dismissToast()
                    }
                } else {
                    cancelDismissToastTask() // Cancel the existing task if it exists
                    withAnimation {
                        showToast = false
                    }
                }
            }
    }

    private func dismissToast() {
        withAnimation {
            isPresented = false
            showToast = false
        }
    }

    private func cancelDismissToastTask() {
        dismissToastTask?.cancel()
        dismissToastTask = nil
    }

    private var toastView: some View {
        SimpleMessageView(message: message, style: style)
            .transition(animation.transition)
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
        - position: The position on the screen where the toast is displayed. This can be `.top`, `.center`, or `.bottom`. The default is `.center`.
        - style: A `ToastStyle` struct used to customize the appearance of the toast, such as background color, text color, corner radius, etc. By default, a standard `ToastStyle` will be applied.
        - animation: A `ToastAnimation` value that determines the animation for the toast. The available options are `.fade`, `.slide(Edge)`, `.scale`, or `.custom(AnyTransition)`. The default animation is `.fade`.
        - onTap: A closure that is triggered when the toast is tapped.

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
        style: ToastStyle = ToastStyle(),
        animation: ToastAnimation = .fade,
        onTap: (() -> Void)? = nil
    ) -> some View {
        modifier(
            EasyToast(
                isPresented: isPresented,
                message: message,
                duration: duration,
                position: position,
                style: style,
                animation: animation,
                onTap: onTap
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
        - animation: A `ToastAnimation` value that determines the animation for the toast. The available options are `.fade`, `.slide(Edge)`, `.scale`, or `.custom(AnyTransition)`. The default animation is `.fade`.
        - onTap: A closure that is triggered when the toast is tapped.

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
        type: ToastType,
        animation: ToastAnimation = .fade,
        onTap: (() -> Void)? = nil
    ) -> some View {
        modifier(
            EasyToast(
                isPresented: isPresented,
                message: message,
                duration: duration,
                position: position,
                style: type.style,
                animation: animation,
                onTap: onTap
            )
        )
    }
}
