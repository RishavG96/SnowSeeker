//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Rishav Gupta on 06/07/23.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.dynamicTypeSize) var typeSize
    
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    
    @EnvironmentObject var favouries: Favourites
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    
                    VStack {
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            Text("Image Credits: \(resort.imageCredit)")
                                .foregroundColor(.primary)
                                .bold()
                        }
                    }
                }
                
                HStack {
                    if sizeClass == .compact && typeSize > .large {
                        VStack(spacing: 10) { ResortDetailsView(resort: resort) }
                        VStack(spacing: 10) { SkiDetailsView(resort: resort) }
                    } else {
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(Color.primary.opacity(0.1))
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge) // all the small size is supported but go upto and including xxxLarge size
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    HStack {
                        ForEach(resort.facilityType) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                    
                    Button(favouries.contains(resort) ? "Remove from favorites" : "Add to favorite") {
                        if favouries.contains(resort) {
                            favouries.remove(resort)
                        } else {
                            favouries.add(resort)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
                .padding(.horizontal)
            }
            .navigationTitle("\(resort.name), \(resort.country)")
            .navigationBarTitleDisplayMode(.inline)
            .alert(selectedFacility?.name ?? "More information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
            } message: { facility in
                Text(facility.description)
            }
        }
    }
}

#Preview {
    ResortView(resort: Resort.example)
        .environmentObject(Favourites())
}
