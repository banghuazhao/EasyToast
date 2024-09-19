# EasyToast

[![Version](https://img.shields.io/github/v/release/banghuazhao/EasyToast)](https://github.com/banghuazhao/EasyToast/releases)
[![License](https://img.shields.io/github/license/banghuazhao/EasyToast)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-iOS%20|%20macOS-blue)](#)
[![Swift Package Manager](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)

## Introduction

**EasyToast** is a lightweight and customizable SwiftUI package that provides easy-to-use toast notifications. Display brief messages to your users with minimal effort.


## Features

- **Simple Text Toasts**: Display a quick message to the user with just a few lines of code.
- **Custom Toast Views**: Create and display fully custom-designed toast notifications.
- **Flexible Positioning**: Position the toast at the top, center, or bottom of the screen.
- **Configurable Duration**: Control how long the toast remains visible.
- **Customizable appearance**: Control background color, text color, corner radius, font, padding, shadow, and text alignment
- **Interactive toasts**: Working in progress 🔨
- **Toast queueing**: Working in progress 🔨
- **Improved animations**: Working in progress 🔨
- **Internationalization**: Working in progress 🔨
- **Accessibility support**: Working in progress 🔨

## 🧳 Requirements

- iOS 15.0+
- Swift 5+

## 💻 Installation

### Swift Package Manager

You can add EasyToast to your project using [Swift Package Manager](https://swift.org/package-manager/).

1. Open your project in Xcode.
2. Go to `File > Add Packages Dependencies...`
3. Enter the package URL: https://github.com/banghuazhao/EasyToast
3. Choose the latest release

Alternatively, add the following to your `Package.swift` file:
```swift
dependencies: [
    .package(url: "https://github.com/banghuazhao/EasyToast.git", from: "1.0.0")
]
```

## 🛠 Usage

### Displaying a Simple Toast

To display a simple toast with a message, use the `easyToast` modifier:

```swift
import EasyToast

struct ContentView: View {
    @State private var showToast = false

    var body: some View {
        content
            .easyToast(isPresented: $showToast, message: "Hello, EasyToast!")
    }
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
}
```

<img src="./Images/3.png" width=200 />

## 💡 Idea

The toast is implemented by overlaying a custom view on top of the view that applies the `.easyToast` modifier, ensuring it seamlessly appears over the current content without disrupting the underlying layout
