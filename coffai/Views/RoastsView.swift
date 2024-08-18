// File: RoastsView.swift
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

import SwiftUI
import SwiftData

struct RoastsView: View {
    @Query var roasts: [RoastData]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        List {
            NavigationLink("Add Roast") {
                EditRoastView()
            }.foregroundStyle(Color.gray)
            ForEach(roasts) { roast in
                NavigationLink {
                    EditRoastView(roast_data: roast)
                } label: {
                    HStack {
                        Image(systemName: "flame")
                        VStack(alignment: .leading) {
                            Text(roast.name).font(.headline).bold()
                            Text(roast.subheading).font(.subheadline)
                        }
                    }
                }
            }.onDelete(perform: { indexSet in
                for i in indexSet {
                    modelContext.delete(roasts[i])
                }
            })
        }
    }
}
