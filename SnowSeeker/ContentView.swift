//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Rishav Gupta on 06/07/23.
//

import SwiftUI

struct User: Identifiable {
    var id = "taylor Swift"
}

struct UserView: View {
    var body: some View {
        Group {
            Text("Name : Paul")
            Text("Country : England")
            Text("pets : Luna and Arya")
        }
        .font(.title)
    }
}

extension View {
    @ViewBuilder func phoneOnlyNavigation() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

enum ResortSorting {
    case Default, Alphabetical, Country
}

struct ContentView: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    
    @State private var searchText = ""
    let allNames = ["Subbh", "Vina", "Melvin", "Stefanie"]
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @StateObject var favouries = Favourites()
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var showingSort = false
    @State private var sorted: ResortSorting = .Default
    
    @State private var showingOptions = false
    @State private var selection = "None"
    
    @State private var filteredResorts = [Resort]()
    
    var body: some View {
//        NavigationView {
//            NavigationLink {
//                Text("New secondary")
//            } label: {
//                Text("Hello world!")
//            }
//            .navigationTitle("Primary")
//            
//            Text("Secondary")
//            
//            Text("Tertiary")
//        }
        
//        Text("hello world")
//            .onTapGesture {
//                selectedUser = User()
//                isShowingUser = true
//            }
////            .sheet(item: $selectedUser) { user in
////                Text(user.id)
////            }
//            .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
//                Button(user.id) { }
//            }
        
//        if sizeClass == .compact {
//            VStack(content: UserView.init)
//        } else {
//            HStack(content: UserView.init)
//        }
        
//        NavigationView {
//            List(fileredNames, id: \.self) {name in
//                Text(name)
//            }
//            .searchable(text: $searchText, prompt: "Look for something")
//            .navigationTitle("Searching")
//        }
        
        NavigationView {
            List(searchText.isEmpty ? filteredResorts : filteredResults) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs)")
                                .foregroundColor(.secondary)
                        }
                        
                        if favouries.contains(resort) {
                            Spacer()
                            
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favourite resport")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .onAppear(perform: {
                self.filteredResorts = resorts
            })
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Button("Order my list") {
                    showingOptions = true
                }
            }
            .confirmationDialog("Select an ordering", isPresented: $showingOptions, titleVisibility: .visible) {
                Button("Default") {
                    sorted = .Default
                    sortList()
                }

                Button("Alphabetical") {
                    sorted = .Alphabetical
                    sortList()
                }

                Button("Country") {
                    sorted = .Country
                    sortList()
                }
            }
            
            WelcomeView()
        }
        .environmentObject(favouries)
//        .phoneOnlyNavigation()
    }
    
    var filteredResults: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var fileredNames: [String] {
        if searchText.isEmpty {
            return allNames
        } else {
            return allNames.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func sortList() {
        switch sorted {
        case .Default:
            filteredResorts = filteredResults
        case .Alphabetical:
            filteredResorts = filteredResults.sorted(by: { $0.name < $1.name })
        case .Country:
            filteredResorts = filteredResults.sorted(by: { $0.country < $1.country })
        }
    }
}

#Preview {
    ContentView()
}
