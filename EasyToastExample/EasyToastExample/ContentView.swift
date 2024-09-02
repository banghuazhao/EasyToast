//
// Created by Banghua Zhao on 30/08/2024
// Copyright Apps Bay Limited. All rights reserved.
//

import EasyToast
import SwiftUI

struct ContentView: View {
    @State var showToast: Bool = false
    @State var showSimpleMessageToastOnTop: Bool = false
    @State var showSimpleMessageToastOnCenter: Bool = false
    @State var showSimpleMessageToastOnBottom: Bool = false
    @State var showCustomToast: Bool = false

    var body: some View {
        List {
            Button("Simple Message Toast") {
                showToast = true
            }
            Button("Simple Message Toast on Top") {
                showSimpleMessageToastOnTop = true
            }
            Button("Simple Message Toast on Center") {
                showSimpleMessageToastOnCenter = true
            }
            Button("Simple Message Toast on Bottom") {
                showSimpleMessageToastOnBottom = true
            }
            Button("Custom Message Toast") {
                showCustomToast = true
            }
        }
        .easyToast(isPresented: $showToast, message: "This is a toast message")
        .easyToast(isPresented: $showSimpleMessageToastOnTop, message: "Simple Message Toast on Top", position: .top)
        .easyToast(isPresented: $showSimpleMessageToastOnCenter, message: "Simple Message Toast on Center", position: .center)
        .easyToast(isPresented: $showSimpleMessageToastOnBottom, message: "Simple Message Toast on Bottom", position: .bottom)
        .easyToast(isPresented: $showCustomToast) {
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
}

#Preview {
    ContentView()
}
