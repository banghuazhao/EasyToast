import SwiftUI
import Combine

public struct ToastItemModifier<Item: Equatable, ToastView: View>: ViewModifier {
    @Binding var item: Item?
    private let duration: Double
    private let position: ToastPosition
    private let animation: ToastAnimation
    private let onTap: (() -> Void)?
    private let content: (Item) -> ToastView

    @State private var showToast: Bool = false
    @State private var dismissToastTask: Task<Void, Never>?

    public init(
        item: Binding<Item?>,
        duration: Double = 2,
        position: ToastPosition = .center,
        animation: ToastAnimation = .fade,
        onTap: (() -> Void)? = nil,
        content: @escaping (Item) -> ToastView
    ) {
        self._item = item
        self.duration = duration
        self.position = position
        self.animation = animation
        self.onTap = onTap
        self.content = content
    }

    public func body(content base: Content) -> some View {
        base
            .overlay(alignment: alignment) {
                if showToast, let item {
                    toastView(for: item)
                        .onTapGesture {
                            onTap?()
                        }
                }
            }
            .onChange(of: item) { newValue in
                handleItemChange(newValue)
            }
    }

    private func handleItemChange(_ newValue: Item?) {
        if newValue != nil {
            withAnimation {
                showToast = true
            }
            cancelDismissToastTask()
            dismissToastTask = Task { @MainActor in
                try? await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
                dismissToast()
            }
        } else {
            cancelDismissToastTask()
            withAnimation {
                showToast = false
            }
        }
    }

    private func dismissToast() {
        withAnimation {
            item = nil
            showToast = false
        }
    }

    private func cancelDismissToastTask() {
        dismissToastTask?.cancel()
        dismissToastTask = nil
    }

    private func toastView(for item: Item) -> some View {
        self.content(item)
            .transition(animation.transition)
    }

    private var alignment: Alignment {
        switch position {
        case .top:
            return .top
        case .center:
            return .center
        case .bottom:
            return .bottom
        }
    }
}

public extension View {
    /**
     Displays a toast notification for a bound optional item, using a custom view.

     - Parameters:
        - item: A binding to an optional item. When non-nil, the toast is shown.
        - duration: The duration in seconds for which the toast is displayed. The default value is 2 seconds.
        - position: The position on the screen where the toast is displayed. The default is `.center`.
        - animation: A `ToastAnimation` value that determines the animation for the toast. The default is `.fade`.
        - onTap: A closure that is triggered when the toast is tapped.
        - content: A closure that returns the custom view to be displayed for the item.

     - Returns: A view that displays the original content overlaid with a custom toast view when `item` is non-nil.

     Example usage:
     ```swift
     .toast(item: $selectedItem) { item in
         // Custom view for the item
     }
     ```
     */
    func toast<Item: Equatable, ToastView: View>(
        item: Binding<Item?>,
        duration: Double = 2,
        position: ToastPosition = .center,
        animation: ToastAnimation = .fade,
        onTap: (() -> Void)? = nil,
        @ViewBuilder content: @escaping (Item) -> ToastView
    ) -> some View {
        self.modifier(ToastItemModifier(
            item: item,
            duration: duration,
            position: position,
            animation: animation,
            onTap: onTap,
            content: content
        ))
    }
} 
