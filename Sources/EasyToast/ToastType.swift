//
// Created by Banghua Zhao on 23/09/2024
// Copyright Apps Bay Limited. All rights reserved.
//
  

public enum ToastType {
    case success
    case error
    case warning
    case info

    var style: ToastStyle {
        switch self {
        case .success:
            return ToastStyle(backgroundColor: .green)
        case .error:
            return ToastStyle(backgroundColor: .red)
        case .warning:
            return ToastStyle(backgroundColor: .orange)
        case .info:
            return ToastStyle(backgroundColor: .blue)
        }
    }
}
