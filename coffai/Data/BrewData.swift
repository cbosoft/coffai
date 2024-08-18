// File: BrewData.swift
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

protocol ToStringable {
    func to_string() -> String
}

enum AromaTastes: String, Codable, CaseIterable, ToStringable {
    case Floral
    case Fruity = "Fruity in general"
    case FruityBerry = "Fruity (berries)"
    case FruityDriedFruit = "Fruity (dried fruit)"
    case FruityCitrus = "Fruity (citrus)"
    case Roasted = "Roasted in general"
    case RoastedCereal = "Roasted (cereals)"
    case RoastedBurnt = "Roasted (burnt)"
    case RoastedTobacco = "Roasted (tobacco)"
    case Nutty
    case Cocoa
    case Spice
    case Sweet = "Sweet in general"
    case SweetVanilla = "Sweet (vanilla)"
    case SweetBrownSugar = "Sweet (brown sugar)"
    case Fermented
    case Sour
    case GreenVegetative = "Green/vegetative"
    case OtherChemical = "Other (chemical)"
    case OtherChemicalMustyEarthy = "Other (musty/earthy)"
    case OtherWoody = "Other (woody)"
    
    func to_string() -> String {
        return self.rawValue
    }
}


enum MainTastes: String, Codable, CaseIterable, ToStringable {
    case Salty
    case Sour
    case Sweet
    case Bitter
    case Umami
    
    func to_string() -> String {
        return self.rawValue
    }
}

enum Mouthfeels: String, Codable, CaseIterable, ToStringable {
    case Rough
    case Smooth
    case Metallic // ?
    case Oily
    case Astringent // AKA moisture-removing
    
    func to_string() -> String {
        return self.rawValue
    }
}

@Model
class BrewData: Hashable {
    var grind: GrindData?
    var method: BrewMethod?
    var date: Date
    
    var grounds_mass: Float?
    var water_mass: Float?
    
    var steep_time: Float?
    
    // SCA(A)
    var descriptive_fragrance_intensity: Int = 1  // 1-9
    var descriptive_aroma_intensity: Int = 1 // 1-9
    var descriptive_aroma_notes: Set<AromaTastes> = Set<AromaTastes>()
    var descriptive_flavour_intensity: Int = 1 // 1-9
    var descriptive_aftertaste_intensity: Int = 1 // 1-9
    var descriptive_flavour_notes: Set<AromaTastes> = Set<AromaTastes>()
    var descriptive_main_tastes: Set<MainTastes> = Set<MainTastes>()
    var descriptive_acidity_intensity: Int = 1 // 1-9
    var descriptive_sweetness_intensity: Int = 1 // 1-9
    var descriptive_mouthfeel_intensity: Int = 1 // 1-9
    var descriptive_mouthfeel: Set<Mouthfeels> = Set<Mouthfeels>()
    
    // Affective
    var affective_fragrance: Int = 1 // 1-9
    var affective_aroma: Int = 1 // 1-9
    var affective_flavour: Int = 1 // 1-9
    var affective_aftertaste: Int = 1 // 1-9
    var affective_acidity: Int = 1 // 1-9
    var affective_sweetness: Int = 1 // 1-9
    var affective_mouthfeel: Int = 1 // 1-9
    var affective_overall: Int = 1 // 1-9
    
    init() {
        self.grind = nil
        self.method = nil
        self.date = .now
        
        self.grounds_mass = 15.0
        self.water_mass = 200.0
    }
    
    static func cupping_score(fragrance: Int, aroma: Int, flavour: Int, aftertaste: Int, acidity: Int, sweetness: Int, mouthfeel: Int, overall: Int) -> Float {
        let sum = fragrance + aroma + flavour + aftertaste + acidity + sweetness + mouthfeel + overall;
        let score = 0.65625 * Float(sum) + 52.75
        return score
    }
    
    func cupping_score() -> Float {
        return Self.cupping_score(
            fragrance: self.affective_fragrance,
            aroma: self.affective_aroma,
            flavour: self.affective_flavour,
            aftertaste: self.affective_aftertaste,
            acidity: self.affective_acidity,
            sweetness: self.affective_sweetness,
            mouthfeel: self.affective_mouthfeel,
            overall: self.affective_overall)
    }
}
