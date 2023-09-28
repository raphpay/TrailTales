//
//  Logo.swift
//  TrailTales
//
//  Created by Raphaël Payet on 26/09/2023.
//

import SwiftUI

struct Logo: View {
    var body: some View {
        Image(AssetsImages.InlineLogo.rawValue)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 50)
    }
}

struct Logo_Previews: PreviewProvider {
    static var previews: some View {
        Logo()
    }
}
