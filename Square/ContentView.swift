//
//  ContentView.swift
//  Square
//
//  Created by Nikolay Volnikov on 12.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var location: CGPoint = CGPoint(x: 150, y: 350)
    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil// 1

    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? location // 3
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                self.location = newLocation
            }.updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? location // 2
            }
    }

    var fingerDrag: some Gesture {
        DragGesture()
            .updating($fingerLocation) { (value, fingerLocation, transaction) in
                fingerLocation = value.location
            }
    }

    var body: some View {

        ZStack {
            VStack(spacing: 0) {
                Rectangle().fill(.white)
                Rectangle().fill(.pink)
                Rectangle().foregroundColor(.yellow)
                Rectangle().foregroundColor(.black)
            }
            .ignoresSafeArea()

            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.white)
                .blendMode(.difference)
                .overlay(RoundedRectangle(cornerRadius: 15).blendMode(.hue))
                .overlay(RoundedRectangle(cornerRadius: 15).foregroundColor(.white).blendMode(.overlay))
                .overlay(RoundedRectangle(cornerRadius: 15).foregroundColor(.black).blendMode(.overlay))
                .frame(width: 100, height: 100)
                .position(location)
                .gesture(simpleDrag.simultaneously(with: fingerDrag))

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
