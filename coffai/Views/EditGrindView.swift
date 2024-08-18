// File: EditGrindView.swift
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
import SwiftData


struct EditGrindView: View {
    @Query var roasts: [RoastData]
    
    let grind: GrindData?
    private var editor_title: String {
        grind == nil ? "Add Grounds" : "Edit Grounds"
    }
    
    @State var roast: RoastData? = nil
    @State var ground_date: Date = .now
    @State var ground_level: GroundLevel = .Medium
    @State var notes: String = ""
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    init(grind: GrindData) {
        self.grind = grind
    }
    
    init() {
        self.grind = nil
    }
    
    private func save() {
        if let grind {
            grind.roast = self.roast
            grind.ground_date = self.ground_date
            grind.ground_level = self.ground_level
            grind.notes = self.notes
        }
        else {
            let grind = GrindData()
            grind.roast = self.roast
            grind.ground_date = self.ground_date
            grind.ground_level = self.ground_level
            grind.notes = self.notes
            modelContext.insert(grind)
        }
    }
    
    var body: some View {
        Form {
            Section {
                Picker("Roast", selection: $roast) {
                    Text("--").tag(nil as RoastData?)
                    ForEach(roasts) { roast in
                        Text(roast.label).tag(roast as RoastData?)
                    }
                }
                NavigationLink("Add Roast") {
                    EditRoastView()
                }.foregroundStyle(Color.gray)
            } header: {
                Text("Roast")
            }
            
            Section {
                DatePicker("Grind date", selection: $ground_date, displayedComponents: .date)
                Picker("Grind level", selection: $ground_level) {
                    ForEach(GroundLevel.allCases, id: \.self) { lvl in
                        Text(lvl.rawValue)
                    }
                }.pickerStyle(.segmented)
            } header: {
                Text("Grind")
            }
            
            Section {
                TextField("Notes", text: $notes, axis: .vertical)
            } header: {
                Text("Notes")
            }
        }.toolbar {
            ToolbarItem(placement: .principal) {
                Text(editor_title)
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    withAnimation {
                        save()
                        dismiss()
                    }
                }
            }
            
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", role: .cancel) {
                    dismiss()
                }
            }
        }.onAppear {
            if let grind {
                self.roast = grind.roast
                self.ground_date = grind.ground_date
                self.ground_level = grind.ground_level
                self.notes = grind.notes
            }
        }
    }
}

