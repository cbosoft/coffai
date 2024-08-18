// File: DebugView.swift
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

struct DebugView : View {
    @Environment(\.modelContext) var modelContext
    
    func refresh() {
        do {
            try modelContext.delete(model: BrewData.self)
            try modelContext.delete(model: BrewMethod.self)
            try modelContext.delete(model: GrindData.self)
            try modelContext.delete(model: RoastData.self)
            try modelContext.delete(model: RoasterData.self)
        } catch {
            print("Failed to clear data: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        Button(action: refresh) {
            Label("Delete all data", systemImage: "trash")
        }
    }
}
