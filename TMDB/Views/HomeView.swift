//
//  ContentView.swift
//  TMDB
//
//  Created by Isaac Higgins on 24/11/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var movieVM: MoviewViewModel
    @State var detailsViewActive = false
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Color("BrightGreen")
                    VStack {
                        TextField("Search", text: $movieVM.searchBarText, prompt: Text("Search").foregroundStyle(.black))
                            .font(Font.custom("Inter", size: 16).weight(.bold))
                            .padding(.leading, 29)
                            .frame(width: 319, height: 43)
                            .background(.white)
                            .cornerRadius(80)
                            .padding(.top, 57)
                            .onChange(of: movieVM.searchBarText, {
                                movieVM.UpdateFilteredListOfMovies()
                            })

                            Spacer()
                        
                        Text("Propular Right now")
                            .font(Font.custom("Jomhuria", size: 60))
                            .foregroundColor(Color(red: 0.2, green: 0.47, blue: 0.41))
                            .frame(width: 340, height: 49, alignment: .topLeading)
                            .padding(.bottom, 23)
                            .padding(.leading, 14)
                    }
                }
                .frame(height: 213)
                
                List {
                    ForEach(movieVM.filteredListOfMovies) { movieData in
                        ZStack {
                            MovieCell(movieData: movieData)
                            NavigationLink(destination: DetailsView(movieInfo: movieData)) {
                                EmptyView()
                            }
                            .opacity(0)
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
                .background(Color.white)
            }
            .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(MoviewViewModel())
}
