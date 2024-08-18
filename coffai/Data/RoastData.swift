// File: RoastData.swift
// Package: coffai
// Created: 13/08/2024
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


enum RoastLevel: String, CaseIterable, Codable {
    case Dark
    case Medium
    case Light
}

@Model
class RoastData: Identifiable {
    var name: String = "(a roast)"
    var roaster: RoasterData? = nil
    var processing: String? = nil
    var origin: String? = nil
    var roast_level: RoastLevel = RoastLevel.Medium
    var roast_date: Date = Date.now
    var brews: [BrewData] = []
    
    init() { }
    
    var label: String {
        get {
            let roaster_name = self.roaster?.name ?? "unkown roaster"
            return "\(self.name) (\(roaster_name))"
        }
    }
    
    var subheading: String {
        get {
            let roaster_name = self.roaster?.name ?? "unkown roaster"
            let date = self.roast_date.formatted(date: .abbreviated, time: .omitted)
            return "\(roaster_name) on \(date)"
        }
    }
}
