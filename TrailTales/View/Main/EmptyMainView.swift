//
//  EmptyMainView.swift
//  TrailTales
//
//  Created by Raphaël Payet on 20/09/2023.
//

import SwiftUI

struct EmptyMainView: View {
    
    @State private var showAddHikeView = false
    @State private var showSearchBar = false
    
    var body: some View {
        ZStack {
            BackgroundImage()
            
            absoluteTexts
            
            // MARK: - Top Bar
            VStack {
                TopBarNav(showSearchIcon: false, showSearchBar: $showSearchBar)
                Spacer()
            }
            
            // MARK: - Add button
            TTAddButton {
                showAddHikeView = true
            }
        }
        .fullScreenCover(isPresented: $showAddHikeView) {
            AddHikeView()
        }
    }
    
    var absoluteTexts: some View {
        ZStack {
            Text("Capture and cherish" + "\n" + "your outdoor memories")
                .position(x: 150, y: 158)
                .font(.system(size: 20, weight: .semibold))
            Text("Add your" + "\n" + "first hike")
                .position(x: 285, y: 583)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
            Image(AssetsImages.RoundedArrow.rawValue)
                .position(x: 320, y: 657)
        }
    }
}

struct EmptyMainView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyMainView()
    }
}