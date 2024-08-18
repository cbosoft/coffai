// File: EditBrewMethodView.swift
// Package: coffai
// Created: 17/08/2024
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

struct EditBrewMethodView: View {
    let method: BrewMethod?
    private var editor_title: String {
        method == nil ? "Add Method" : "Edit Method"
    }
    
    @State var name: String = "a brew method"
    @State var method_description: String = ""
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    init(method: BrewMethod) {
        self.method = method
    }
    
    init() {
        self.method = nil
    }
    
    private func save() {
        if let method = self.method {
            method.name = self.name
            method.method_description = self.method_description
        }
        else {
            let method = BrewMethod()
            method.name = self.name
            method.method_description = method_description
            modelContext.insert(method)
        }
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)
                TextField("Description", text: $method_description)
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
            if let method = self.method {
                self.name = method.name
                self.method_description = method.method_description
            }
        }
    }
}
