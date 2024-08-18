// File: FlavourNotesView.swift
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

struct FlavourNotesView: View {
    @Binding var tags: Set<AromaTastes>
    var body: some View {
        List {
            ForEach(AromaTastes.allCases, id: \.self) { aroma_taste in
                HStack {
                    Image(systemName: tags.contains(aroma_taste) ? "checkmark.circle" : "circle")
                    Text(aroma_taste.rawValue).fixedSize()
                    Spacer()
                }
                .onTapGesture {
                    if tags.contains(aroma_taste) {
                        tags.remove(aroma_taste)
                    }
                    else {
                        tags.insert(aroma_taste)
                    }
                }
            }
        }
    }
}

struct MainTastesView: View {
    @Binding var tags: Set<MainTastes>
    var body: some View {
        List {
            ForEach(MainTastes.allCases, id: \.self) { main_taste in
                HStack {
                    Image(systemName: tags.contains(main_taste) ? "checkmark.circle" : "circle")
                    Text(main_taste.rawValue).fixedSize()
                    Spacer()
                }
                .onTapGesture {
                    if tags.contains(main_taste) {
                        tags.remove(main_taste)
                    }
                    else {
                        tags.insert(main_taste)
                    }
                }
            }
        }
    }
}

struct MouthfeelsView: View {
    @Binding var tags: Set<Mouthfeels>
    var body: some View {
        List {
            ForEach(Mouthfeels.allCases, id: \.self) { mouthfeel in
                HStack {
                    Image(systemName: tags.contains(mouthfeel) ? "checkmark.circle" : "circle")
                    Text(mouthfeel.rawValue).fixedSize()
                    Spacer()
                }
                .onTapGesture {
                    if tags.contains(mouthfeel) {
                        tags.remove(mouthfeel)
                    }
                    else {
                        tags.insert(mouthfeel)
                    }
                }
            }
        }
    }
}

struct TagCloudView<T: Hashable & ToStringable>: View {
    @Binding var tags: Set<T>
    var all_tags: Array<T>

    @State private var totalHeight
          = CGFloat.zero       // << variant for ScrollView/List
       // = CGFloat.infinity   // << variant for VStack

    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)// << variant for ScrollView/List
        //.frame(maxHeight: totalHeight) // << variant for VStack
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.all_tags, id: \.self) { tag in
                self.item(for: tag, selected: self.tags.contains(tag))
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == self.all_tags.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag == self.all_tags.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func item(for tag: T, selected: Bool) -> some View {
        Text(tag.to_string())
            .padding(.all, 2)
            .font(.body)
            .background(selected ? Color.accentColor : Color.white)
            .foregroundColor(selected ? Color.white : Color.gray)
            .cornerRadius(2)
            .onTapGesture {
                if selected {
                    self.tags.remove(tag)
                }
                else {
                    self.tags.insert(tag)
                }
            }
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}
