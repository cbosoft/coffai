// File: RatingView.swift
// Package: coffai
// Created: 18/08/2024
//
// MIT License
// 
// Copyright © 2020 Christopher Boyle
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import SwiftUI

enum RatingStyle {
    case stars
    case circles
    case squares
}

struct RatingView: View {
    @Binding var rating: Int
    var total: Int = 5
    var range: Array<Int> {
        get {
            Array(1..<total)
        }
    }
    
    var style: RatingStyle = .stars
    var off_system_image: String {
        switch style {
        case .stars:
            return "star"
        case .circles:
            return "circle"
        case .squares:
            return "square"
        }
    }
    var on_system_image: String {
        switch style {
        case .stars:
            return "star.fill"
        case .circles:
            return "circle.fill"
        case .squares:
            return "square.fill"
        }
    }

    var off_colour = Color.gray
    var on_colour = Color.accentColor
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Spacer()
                ForEach(range, id: \.self) { number in
                    Image(systemName: number <= self.rating ? on_system_image : off_system_image)
                        .foregroundColor(number <= self.rating ? self.on_colour : self.off_colour)
                        .onTapGesture {
                            self.rating = number
                        }
                    Spacer()
                }
            }
            HStack(alignment: .top) {
                Text("Extremely low")
                Spacer()
                Text("Extremely high")
            }.font(.footnote).foregroundStyle(Color.gray)
        }
    }
}
