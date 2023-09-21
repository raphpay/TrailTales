//
//  BackgroundImage.swift
//  TrailTales
//
//  Created by Raphaël Payet on 20/09/2023.
//

import SwiftUI

struct BackgroundImage: View {
    
    var blurRadius: CGFloat = 0
    
    var body: some View {
        Image(AssetsImages.BackgroundImage.rawValue)
            .resizable()
            .blur(radius: blurRadius)
            .edgesIgnoringSafeArea(.all)
    }
}

struct BackgroundImage_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImage()
    }
}
