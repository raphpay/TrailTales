//
//  ClearBackgroundImage.swift
//  TrailTales
//
//  Created by Raphaël Payet on 26/09/2023.
//

import SwiftUI

struct ClearBackgroundImage: View {
    
    var image: String
    var opacity: Double = 0.7
    
    var body: some View {
        Rectangle()
          .foregroundColor(.clear)
          .background(.white.opacity(0.7))
          .background(
            Image(image)
              .resizable()
              .aspectRatio(contentMode: .fill)
              .clipped()
          )
          .edgesIgnoringSafeArea(.all)
    }
}

struct ClearBackgroundImage_Previews: PreviewProvider {
    static var previews: some View {
        ClearBackgroundImage(image: AssetsImages.LoginBackground.rawValue)
    }
}
