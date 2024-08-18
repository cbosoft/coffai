// File: EditBrewView.swift
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
import SwiftData


struct EditBrewView: View {
    @Query var methods: [BrewMethod]
    @Query var grinds: [GrindData]
    
    let brew: BrewData?
    private var editor_title: String {
        brew == nil ? "Add Brew" : "Edit Brew"
    }
    
    @State var grind: GrindData? = nil
    @State var method: BrewMethod? = nil
    @State var date: Date = .now
    
    @State var grounds_mass: Float? = 15.0
    @State var water_mass: Float? = 200.0
    
    @State var steep_time: Float? = 300.0
    
    // SCA(A)
    @State var descriptive_fragrance_intensity: Int = 1
    @State var descriptive_aroma_intensity: Int = 1
    @State var descriptive_aroma_notes: Set<AromaTastes> = Set<AromaTastes>()
    @State var descriptive_flavour_intensity: Int = 1
    @State var descriptive_aftertaste_intensity: Int = 1
    @State var descriptive_flavour_notes: Set<AromaTastes> = Set<AromaTastes>()
    @State var descriptive_main_tastes: Set<MainTastes> = Set<MainTastes>()
    @State var descriptive_acidity_intensity: Int = 1
    @State var descriptive_sweetness_intensity: Int = 1
    @State var descriptive_mouthfeel_intensity: Int = 1
    @State var descriptive_mouthfeel: Set<Mouthfeels> = Set<Mouthfeels>()
    
    // Affective
    @State var affective_fragrance: Int = 1 // 1-9
    @State var affective_aroma: Int = 1 // 1-9
    @State var affective_flavour: Int = 1 // 1-9
    @State var affective_aftertaste: Int = 1 // 1-9
    @State var affective_acidity: Int = 1 // 1-9
    @State var affective_sweetness: Int = 1 // 1-9
    @State var affective_mouthfeel: Int = 1 // 1-9
    @State var affective_overall: Int = 1 // 1-9
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    init(brew: BrewData) {
        self.brew = brew
    }
    
    init() {
        self.brew = nil
    }
    
    private func save() {
        if let brew = self.brew {
            brew.grind = self.grind
            brew.method = self.method
            brew.date = self.date
            brew.grounds_mass = self.grounds_mass
            brew.water_mass = self.water_mass
            brew.steep_time = self.steep_time
            
            brew.descriptive_fragrance_intensity = self.descriptive_fragrance_intensity
            brew.descriptive_aroma_intensity = self.descriptive_aroma_intensity
            brew.descriptive_aroma_notes = self.descriptive_aroma_notes
            brew.descriptive_flavour_intensity = self.descriptive_flavour_intensity
            brew.descriptive_aftertaste_intensity = self.descriptive_aftertaste_intensity
            brew.descriptive_flavour_notes = self.descriptive_flavour_notes
            brew.descriptive_main_tastes = self.descriptive_main_tastes
            brew.descriptive_acidity_intensity = self.descriptive_acidity_intensity
            brew.descriptive_sweetness_intensity = self.descriptive_sweetness_intensity
            brew.descriptive_mouthfeel_intensity = self.descriptive_mouthfeel_intensity
            brew.descriptive_mouthfeel = self.descriptive_mouthfeel
            
            brew.affective_fragrance = self.affective_fragrance
            brew.affective_aroma = self.affective_aroma
            brew.affective_flavour = self.affective_flavour
            brew.affective_aftertaste = self.affective_aftertaste
            brew.affective_acidity = self.affective_acidity
            brew.affective_sweetness = self.affective_sweetness
            brew.affective_mouthfeel = self.affective_mouthfeel
            brew.affective_overall = self.affective_overall
        }
        else {
            let brew = BrewData()
            brew.grind = self.grind
            brew.method = self.method
            brew.date = self.date
            brew.grounds_mass = self.grounds_mass
            brew.water_mass = self.water_mass
            brew.steep_time = self.steep_time
            
            brew.descriptive_fragrance_intensity = self.descriptive_fragrance_intensity
            brew.descriptive_aroma_intensity = self.descriptive_aroma_intensity
            brew.descriptive_aroma_notes = self.descriptive_aroma_notes
            brew.descriptive_flavour_intensity = self.descriptive_flavour_intensity
            brew.descriptive_aftertaste_intensity = self.descriptive_aftertaste_intensity
            brew.descriptive_flavour_notes = self.descriptive_flavour_notes
            brew.descriptive_main_tastes = self.descriptive_main_tastes
            brew.descriptive_acidity_intensity = self.descriptive_acidity_intensity
            brew.descriptive_sweetness_intensity = self.descriptive_sweetness_intensity
            brew.descriptive_mouthfeel_intensity = self.descriptive_mouthfeel_intensity
            brew.descriptive_mouthfeel = self.descriptive_mouthfeel
            
            brew.affective_fragrance = self.affective_fragrance
            brew.affective_aroma = self.affective_aroma
            brew.affective_flavour = self.affective_flavour
            brew.affective_aftertaste = self.affective_aftertaste
            brew.affective_acidity = self.affective_acidity
            brew.affective_sweetness = self.affective_sweetness
            brew.affective_mouthfeel = self.affective_mouthfeel
            brew.affective_overall = self.affective_overall
            
            modelContext.insert(brew)
        }
    }
    
    func cupping_score() -> Float {
        return BrewData.cupping_score(
            fragrance: self.affective_fragrance,
            aroma: self.affective_aroma,
            flavour: self.affective_flavour,
            aftertaste: self.affective_aftertaste,
            acidity: self.affective_acidity,
            sweetness: self.affective_sweetness,
            mouthfeel: self.affective_mouthfeel,
            overall: self.affective_overall
        )
    }
    
    func grounds_water_ratio() -> String {
        guard (grounds_mass != nil) && (water_mass != nil) else {
            return "--"
        }
        
        let ratio = grounds_mass! / water_mass!
        return "\(ratio)"
    }
    
    var body: some View {
        Form {
            Section {
                DatePicker("Brew date", selection: $date, displayedComponents: .date)
                Picker("Method", selection: $method) {
                    Text("--").tag(nil as BrewMethod?)
                    ForEach(methods) { method in
                        Text("\(method.name)").tag(method as BrewMethod?)
                    }
                }
                NavigationLink("Add Method") {
                    EditBrewMethodView(method: BrewMethod())
                }.foregroundStyle(Color.gray)
            }
            
            Section {
                Picker("Grind", selection: $grind) {
                    Text("--").tag(nil as GrindData?)
                    ForEach(grinds) { grind in
                        Text(grind.label).tag(grind as GrindData?)
                    }
                }
                NavigationLink("Grind some beans") {
                    EditRoastView()
                }.foregroundStyle(Color.gray)
            } header: {
                Text("Roast")
            }
            
            Section {
                HStack {
                    Text("Grounds mass (g)")
                    Spacer()
                    TextField("mass (g)", value: $grounds_mass, format: .number).keyboardType(.decimalPad).fixedSize()
                }
                HStack {
                    Text("Water mass (g)")
                    Spacer()
                    TextField("mass (g)", value: $water_mass, format: .number).keyboardType(.decimalPad).fixedSize()
                }
            } header: {
                Text("Grounds-water ratio")
            } footer: {
                Text("\(grounds_water_ratio()) (g coffee / g water)")
            }
            
            Section {
                HStack {
                    Text("Steep time (s)")
                    Spacer()
                    TextField("Steep time (s)", value: $steep_time, format: .number).keyboardType(.decimalPad).fixedSize()
                }
            } header: {
                Text("Steep time")
            }
            
            Section {
                Text("This section encompases all objective descriptions of the brew. What can you taste, smell, feel? This is not about judging these factors according to taste; it is about facts.")
                HStack { Text("Fragrance Intensity"); Spacer(); Text("(dry grounds)").font(.footnote) }
                RatingView(rating: $descriptive_fragrance_intensity, total: 9, style: .circles)
                HStack { Text("Aroma Intensity"); Spacer(); Text("(wet grounds)").font(.footnote) }
                RatingView(rating: $descriptive_aroma_intensity, total: 9, style: .circles)
                Text("Fragrance and aroma detail")
                TagCloudView(tags: $descriptive_aroma_notes, all_tags: AromaTastes.allCases)
                
                Text("Flavour Intensity")
                RatingView(rating: $descriptive_flavour_intensity, total: 9, style: .circles)
                Text("Aftertaste Intensity")
                RatingView(rating: $descriptive_aftertaste_intensity, total: 9, style: .circles)
                Text("Flavour and aftertaste detail")
                TagCloudView(tags: $descriptive_flavour_notes, all_tags: AromaTastes.allCases)
                Text("Main tastes")
                TagCloudView(tags: $descriptive_main_tastes, all_tags: MainTastes.allCases)
                
                Text("Acidity Intensity")
                RatingView(rating: $descriptive_acidity_intensity, total: 9, style: .circles)
                Text("Sweetness Intensity")
                RatingView(rating: $descriptive_sweetness_intensity, total: 9, style: .circles)
                Text("Mouthfeel Intensity")
                RatingView(rating: $descriptive_mouthfeel_intensity, total: 9, style: .circles)
                Text("Mouthfeel Detail")
                TagCloudView(tags: $descriptive_mouthfeel, all_tags: Mouthfeels.allCases)
            } header: {
                Text("SCA: Descriptive")
            }
            
            Section {
                Text("This section is about assessing how you feel about the brew. How does each part rate?")
                Text("Fragrance")
                RatingView(rating: $affective_fragrance, total: 9)
                Text("Aroma")
                RatingView(rating: $affective_aroma, total: 9)
                Text("Flavour")
                RatingView(rating: $affective_flavour, total: 9)
                Text("Acidity")
                RatingView(rating: $affective_acidity, total: 9)
                Text("Sweetness")
                RatingView(rating: $affective_sweetness, total: 9)
                Text("Mouthfeel")
                RatingView(rating: $affective_mouthfeel, total: 9)
                Text("Overall")
                RatingView(rating: $affective_overall, total: 9)
                
            } header: {
                Text("SCA: Affective")
            } footer: {
                Text(String(format: "Score: %.2f", self.cupping_score()))
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
            if let brew = brew {
                self.grind = brew.grind
                self.method = brew.method
                self.date = brew.date
                self.grounds_mass = brew.grounds_mass
                self.water_mass = brew.water_mass
                self.steep_time = brew.steep_time
                
                self.descriptive_fragrance_intensity = brew.descriptive_fragrance_intensity
                self.descriptive_aroma_intensity = brew.descriptive_aroma_intensity
                self.descriptive_aroma_notes = brew.descriptive_aroma_notes
                self.descriptive_flavour_intensity = brew.descriptive_flavour_intensity
                self.descriptive_aftertaste_intensity = brew.descriptive_aftertaste_intensity
                self.descriptive_flavour_notes = brew.descriptive_flavour_notes
                self.descriptive_main_tastes = brew.descriptive_main_tastes
                self.descriptive_acidity_intensity = brew.descriptive_acidity_intensity
                self.descriptive_sweetness_intensity = brew.descriptive_sweetness_intensity
                self.descriptive_mouthfeel_intensity = brew.descriptive_mouthfeel_intensity
                self.descriptive_mouthfeel = brew.descriptive_mouthfeel
                
                self.affective_fragrance = brew.affective_fragrance
                self.affective_aroma = brew.affective_aroma
                self.affective_flavour = brew.affective_flavour
                self.affective_aftertaste = brew.affective_aftertaste
                self.affective_acidity = brew.affective_acidity
                self.affective_sweetness = brew.affective_sweetness
                self.affective_mouthfeel = brew.affective_mouthfeel
                self.affective_overall = brew.affective_overall
            }
        }
    }
}
