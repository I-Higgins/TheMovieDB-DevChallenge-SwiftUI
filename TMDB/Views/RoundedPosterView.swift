//
//  RoundedPosterView.swift
//  TMDB
//
//  Created by Isaac Higgins on 27/11/23.
//

import SwiftUI

struct RoundedPosterView: View {
    var image: UIImage
    var body: some View {
        VStack{
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: 130, height: 172)
                    .clipShape(
                        .rect(
                            topTrailingRadius: 35))
                
                
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 120, height: 162)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(
                        .rect(
                            topTrailingRadius: 30))
                
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black
        RoundedPosterView(image: UIImage(named: "Oppenheimer") ?? UIImage())
    }
}
