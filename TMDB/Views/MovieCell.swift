//
//  MovieCell.swift
//  TMDB
//
//  Created by Isaac Higgins on 24/11/23.
//

import SwiftUI

struct MovieCell: View {
    var movieData: MovieData
    var body: some View {
        HStack (alignment: .bottom, spacing: 27) {
            Image(uiImage: UIImage(data: movieData.posterImage) ?? UIImage())
                .resizable()
                .foregroundColor(.clear)
                .frame(width: 85, height: 131)
                .cornerRadius(8)
                .scaledToFit()
            
            VStack(alignment: .leading) {
                
                Text(movieData.movieInfo.title!)
                    .font(Font.custom("Inter", size: 16).weight(.bold))
                    .foregroundColor(.black)
                    .frame(width: 220, height: 18, alignment: .topLeading)
                    .padding(.top, 24)
                Text(movieData.movieInfo.release_date!.prefix(4))
                    .font(Font.custom("Inter", size: 12))
                    .foregroundColor(Color(red: 0.58, green: 0.58, blue: 0.58))
                    .frame(width: 165, height: 18, alignment: .topLeading)
                
                HStack {
                    Text(String(format: "%.0f",(movieData.movieInfo.vote_average! * 10)) + "%")
                        .font(Font.custom("Inter", size: 12).weight(.bold))
                        .foregroundColor(.black)
                    Text("user score")
                        .font(Font.custom("Inter", size: 12))
                        .foregroundColor(.black)
                }
                
                Spacer()
                GenresView(items: movieData.movieInfo.genre_ids!.map({GenreDictionary[$0] ?? ""}))
            }
        }
        .frame(width: 332, height: 131, alignment: .bottom)
    }
}

#Preview {
    MovieCell(movieData: MovieData(posterImage: UIImage(named: "Oppenheimer")?.pngData() ?? Data(), movieInfo: MovieModel(genre_ids: [28, 35, 28, 28], release_date: "2023-08-21",title: "Oppenheimer", vote_average: 7.921)))
}
