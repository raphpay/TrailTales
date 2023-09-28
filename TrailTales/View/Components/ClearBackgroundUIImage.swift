//
//  ClearBackgroundUIImage.swift
//  TrailTales
//
//  Created by Raphaël Payet on 28/09/2023.
//

import SwiftUI

struct ClearBackgroundUIImage: View {
    
    var uiImage: UIImage
    
    var body: some View {
        Rectangle()
          .foregroundColor(.clear)
          .background(.white.opacity(0.7))
          .background(
            Image(uiImage: uiImage)
              .resizable()
              .aspectRatio(contentMode: .fill)
              .clipped()
          )
          .edgesIgnoringSafeArea(.all)
    }
}
