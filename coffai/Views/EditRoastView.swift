// File: EditRoastView.swift
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


struct EditRoastView: View {
    @Query var roasters: [RoasterData]
    
    let roast_data: RoastData?
    private var editor_title: String {
        roast_data == nil ? "Add Roast" : "Edit Roast"
    }
    
    @State var name: String = "(a roast)"
    @State var roaster: RoasterData? = nil
    @State var processing: String = ""
    @State var origin: String = ""
    @State var roast_level: RoastLevel = RoastLevel.Medium
    @State var roast_date: Date = Date.now
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    init(roast_data: RoastData) {
        self.roast_data = roast_data
    }
    
    init() {
        self.roast_data = nil
    }
    
    private func save() {
        if let roast_data {
            roast_data.name = name
            roast_data.roaster = roaster
            roast_data.processing = processing.count > 0 ? processing : nil
            roast_data.origin = origin.count > 0 ? origin : nil
            roast_data.roast_level = roast_level
            roast_data.roast_date = roast_date
        }
        else {
            let roast_data = RoastData()
            roast_data.name = name
            roast_data.roaster = roaster
            roast_data.processing = processing.count > 0 ? processing : nil
            roast_data.origin = origin.count > 0 ? origin : nil
            roast_data.roast_level = roast_level
            roast_data.roast_date = roast_date
            modelContext.insert(roast_data)
        }
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)
            }
            
            Section {
                Picker("Roaster", selection: $roaster) {
                    Text("--").tag(nil as RoasterData?)
                    ForEach(roasters) { roaster in
                        Text(roaster.name).tag(roaster as RoasterData?)
                    }
                }
                NavigationLink("Add Roaster") {
                    EditRoasterView()
                }.foregroundStyle(Color.gray)
            } header: {
                Text("Roaster")
            }
            
            Section {
                TextField("Origin", text: $origin, axis: .vertical)
                Picker("Roast", selection: $roast_level) {
                    ForEach(RoastLevel.allCases, id: \.self) { roast_level in
                        Text(roast_level.rawValue)
                    }
                }.pickerStyle(.segmented)
                DatePicker("Roasted on", selection: $roast_date, displayedComponents: .date)
            } header: {
                Text("Details")
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
            if let roast_data {
                name = roast_data.name
                roaster = roast_data.roaster
                processing = roast_data.processing ?? ""
                origin = roast_data.origin ?? ""
                roast_date = roast_data.roast_date
                roast_level = roast_data.roast_level
            }
        }
    }
}
