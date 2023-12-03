//
//  GenreCell.swift
//  TMDB
//
//  Created by Isaac Higgins on 24/11/23.
//

import SwiftUI

struct GenresView: View {
    let genreStrings: [String]
    var groupedItems: [[String]] = [[String]]()
    
    init(items: [String]) {
        self.genreStrings = items
        self.groupedItems = createGroupedItems(items)
    }
    
    private func createGroupedItems(_ items: [String]) -> [[String]] {
        var groupedItems: [[String ]] = [[String]]()
        var tempItems: [String] = [String]()
        var width: CGFloat = 0
        for word in items {
            let label = UILabel()
            label.text = word
            let labelWidth = label.frame.size.width + 32
            
            if (width + labelWidth + 32) < 150 {
                width += labelWidth
                tempItems.append(word)
            } else {
                width = labelWidth
                groupedItems.append(tempItems)
                tempItems.removeAll()
                tempItems.append(word)
            }
        }
        groupedItems.append(tempItems)
        return groupedItems
    }
    
    var body: some View {
        VStack {
            ForEach(groupedItems, id: \.self) { subItems in
                HStack {
                    ForEach(subItems, id: \.self) { word in
                        GenreCell(text: word)
                    }
                }
            }
        }
    }
}

struct GenreCell: View {
    var text: String
    var body: some View {
        Text(text)
            .font(Font.custom("Inter", size: 12))
            .foregroundColor(Color(red: 0.58, green: 0.58, blue: 0.58))
            .padding(.horizontal, 6)
            .padding(.vertical, 3)
            .background(Color(red: 0.9, green: 0.9, blue: 0.9))
            .cornerRadius(30)
    }
}

#Preview {
    VStack {
        GenreCell(text: "Action")
        GenresView(items: ["Action", "Adventure", "Science Fiction"])
    }
    .frame(maxWidth: 220)
}
