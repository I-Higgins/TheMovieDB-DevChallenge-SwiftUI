//
//  StarView.swift
//  TMDB
//
//  Created by Isaac Higgins on 3/12/23.
//

import SwiftUI

struct StarView: View {
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(.white)
                .frame(width: 48, height: 48)
                .shadow(color: .black.opacity(0.8), radius: 2, x: 0, y: 4)
            
            Image(uiImage: UIImage(named: "Component 2")!)
                .frame(width: 28.18439, height: 26.90372)
        }
    }
}


#Preview {
    StarView()
}
