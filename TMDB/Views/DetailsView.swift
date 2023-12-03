//
//  DetailsView.swift
//  TMDB
//
//  Created by Isaac Higgins on 25/11/23.
//

import SwiftUI

struct DetailsView: View {
    @EnvironmentObject var movieVM: MoviewViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var movieInfo: MovieData
    var body: some View {
        ZStack {
            Banner(image: movieInfo.getBackDropImage(), title: movieInfo.movieInfo.title)
            
            HStack(alignment: .top, spacing: 0) {
                VStack {
                    RoundedPosterView(image: movieInfo.getPosterImage())
                    Spacer()
                }
                
                MovieDetails(movieInfo: movieInfo.movieInfo)
                    .padding(.top, 55)
                    .padding(.leading, 15)
                Spacer()
            }
            .padding(.top, 194)
            .padding(.leading, 32)
            
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 10) {
                    RateItMyself()
                    ViewFavs()
                    Spacer()
                }
                .padding(.leading, 37)
                .padding(.top, 388)
                Spacer()
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Overview")
                        .font(Font.custom("Inter", size: 16).weight(.bold))
                    
                    Text(movieInfo.movieInfo.overview)
                        .font(Font.custom("Inter", size: 16))
                        .frame(width: 305, height: 265, alignment: .topLeading)
                        .padding(.top, 14)
                    Spacer()
                }
                Spacer()
            }
            .padding(.leading, 37)
            .padding(.top, 477)
            
            VStack {
                HStack {
                    StarView()
                        .padding(.leading, 153)
                        .padding(.top, 161)
                    Spacer()
                }
                Spacer()
            }
            
//            VStack {
//                HStack {
//                    Button(action: {
//                        presentationMode.wrappedValue.dismiss()
//                    }, label: {
//                        BackButton()
//                    })
//                    .padding(.leading, 34)
//                    .padding(.top, 31)
//                    Spacer()
//                }
//                Spacer()
//            }
        }
        .ignoresSafeArea(.all)
        .onAppear {
            movieVM.RetrieveMovieBackDrop(movieInfo: movieInfo.movieInfo) { _ in }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    BackButton()
                })
            }
        }
    }
}

#Preview {
    DetailsView(movieInfo: MovieData(posterImage: UIImage(named: "Oppenheimer")?.pngData() ?? Data(), backDropImage: UIImage(named: "OppenheimerBackDrop")?.pngData() ?? Data(), movieInfo: MovieModel(backdrop_path: "/fm6KqXpk3M2HVveHwCrBSSBaO0V.jpg", genre_ids: [28, 35, 28, 28], overview: "This is the overview for the Oppenheimer movie", release_date: "2023-08-21", title: "Oppenheimer", vote_average: 7.921)))
        .environmentObject(MoviewViewModel())
}


struct RateItMyself: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("Rate it myself")
                .font(Font.custom("Inter", size: 16))
                .foregroundStyle(.white)
                .frame(width: 150, height: 27, alignment: .center)
                .background(Color(red: 0.67, green: 0.5, blue: 0.25))
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            Text("add personal rating")
                .font(Font.custom("Inter", size: 12))
                .foregroundStyle(Color(red: 0.84, green: 0.73, blue: 0.56))
                .frame(width: 150, height: 29, alignment: .center)
                .background(.black)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
        }
        .cornerRadius(10)
    }
}

struct ViewFavs: View {
    var body: some View {
        Text("View Favs")
            .font(Font.custom("Inter", size: 16))
            .multilineTextAlignment(.center)
            .foregroundColor(Color(red: 0.73, green: 0.55, blue: 0.12))
            .frame(width: 145, height: 56, alignment: .center)
            .background(Color(red: 1, green: 0.95, blue: 0.83))
            .cornerRadius(80)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
    }
}

struct Banner: View {
    var image: UIImage
    var title: String
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                Image(uiImage: image)
                    .resizable()
                    .frame(height: 243)
                    .scaledToFit()
                
                HStack {
                    Text(title)
                        .font(Font.custom("Jomhuria", size: 96).weight(.bold))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .padding(.top, 75)
                        .padding(.leading, 32)
                    Spacer()
                }
            }
            .ignoresSafeArea(.all)
            Spacer()
        }
    }
}

struct MovieDetails: View {
    var movieInfo: MovieModel
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            Text(movieInfo.title)
                .font(Font.custom("Inter", size: 16).weight(.bold))
                .frame(height: 18)
                .padding(.bottom, 8)
            
            Text(movieInfo.release_date.prefix(4))
                .font(Font.custom("Inter", size: 12))
                .foregroundColor(Color(red: 0.58, green: 0.58, blue: 0.58))
                .frame(height: 18)
            
            HStack(spacing: 0) {
                ForEach (movieInfo.getGenreStrings(), id: \.self) { genreString in
                    Text(genreString)
                        .font(Font.custom("Inter", size: 12))
                        .foregroundColor(Color(red: 0.58, green: 0.58, blue: 0.58))
                        .frame(height: 18, alignment: .leading)
                        .padding(.trailing, 8)
                }
            }
            
            HStack(alignment: .top) {
                Text(String(format: "%.0f", movieInfo.getVotePercentage()))
                .font(Font.custom("Inter", size: 20).weight(.bold))
                
                Text("%")
                    .font(Font.custom("Inter", size: 12).weight(.bold))
                    .padding(.leading, -7)
                
                Text("user score")
                .font(Font.custom("Inter", size: 12))
                .padding(.leading, 9)
                .padding(.top, 4)
                
                Spacer()
            }
            .padding(.top, 15)
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 130, height: 4)
                    .background(Color(red: 0.82, green: 0.82, blue: 0.82))
                
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: CGFloat(13 * movieInfo.vote_average), height: 4)
                  .background(Color(red: 0.3, green: 0.67, blue: 0.29))
            }
            .padding(.top, 3)
        }
    }
}

struct BackButton: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.white.opacity(0.3))
                .cornerRadius(60)
                .frame(width: 136, height: 26, alignment: .center)
            
            HStack(spacing: 10) {
                Image(uiImage: UIImage(named: "Vector")!)
                    .frame(width: 6, height: 10)
                
                Text("Back to Search")
                    .font(Font.custom("Inter", size: 10))
                    .foregroundColor(.white)
                    .background(.clear)
                    .frame(height: 26, alignment: .center)
            }
        }
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
