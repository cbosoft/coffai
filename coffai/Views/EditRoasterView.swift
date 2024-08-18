// File: EditRoasterView.swift
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

struct EditRoasterView: View {
    let roaster: RoasterData?
    private var editor_title: String {
        roaster == nil ? "Add Roaster" : "Edit Roaster"
    }
    
    @State var name: String = "a roaster"
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    init(roaster: RoasterData) {
        self.roaster = roaster
    }
    
    init() {
        self.roaster = nil
    }
    
    private func save() {
        if let roaster = self.roaster {
            roaster.name = self.name
        }
        else {
            let roaster = RoasterData(name: name)
            modelContext.insert(roaster)
        }
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Roaster", text: $name)
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
            if let roaster = self.roaster {
                self.name = roaster.name
            }
        }
    }
}
