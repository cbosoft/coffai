// File: GrindData.swift
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

import Foundation
import SwiftData

enum GroundLevel: String, Codable, CaseIterable {
    case Finest
    case Fine
    case Medium
    case Coarse
    case Coarsest
}

@Model
class GrindData: Hashable {
    var roast: RoastData?
    var ground_date: Date
    var ground_level: GroundLevel
    var notes: String
    
    // TODO: images
    
    var label: String {
        let roast = roast == nil ? "unknown roast" : roast!.label
        let date = ground_date.formatted(date: .abbreviated, time: .omitted)
        return "\(roast) ground on \(date) (\(ground_level))"
    }
    
    init() {
        self.roast = nil
        self.ground_date = .now
        self.ground_level = .Medium
        self.notes = ""
    }
}
