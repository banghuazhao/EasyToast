# EasyToast

**EasyToast** is a simple, lightweight, flexible, and easy-to-use library for showing toast in **SwiftUI**. Whether you need a quick and easy way to present a brief message to your users or a fully custom-designed toast, EasyToast provides the tools to do it seamlessly.

## Features

- **Simple Text Toasts**: Display a quick message to the user with just a few lines of code.
- **Custom Toast Views**: Create and display fully custom-designed toast notifications.
- **Flexible Positioning**: Position the toast at the top, center, or bottom of the screen.
- **Configurable Duration**: Control how long the toast remains visible.

## 🧳 Requirements

- iOS 15.0+
- Swift 5+

## 💻 Installation

### Swift Package Manager

You can add EasyToast to your project using [Swift Package Manager](https://swift.org/package-manager/).

1. In Xcode, go to `File > Add Packages...`
2. Enter the package URL: https://github.com/banghuazhao/EasyToast
3. Select the desired version or branch and add it to your project.

## 🛠 Usage

### Displaying a Simple Toast

To display a simple toast with a message, use the `easyToast` modifier:

```swift
import EasyToast

var body: some View {
    content
        .easyToast(isPresented: $showToast, message: "This is a toast message")
}
```

<img src="./Images/1.png" width=200 />

### Displaying a Simple Toast on Top

To display a simple toast with a message, use the `easyToast` modifier:

```swift
var body: some View {
    content
        .easyToast(isPresented: $showToast, message: "This is a toast message on top", position: .top)
}
```

<img src="./Images/2.png" width=200 />

### Displaying a Custom Toast

To display a custom-designed toast view, use the `easyToast` modifier with a custom view:

```swift
var body: some View {
    content
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
}
```

<img src="./Images/3.png" width=200 />

## 💡 Idea

The toast is implemented by overlaying a custom view on top of the view that applies the `.easyToast` modifier, ensuring it seamlessly appears over the current content without disrupting the underlying layout