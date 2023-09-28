//
//  View+Ext.swift
//  TrailTales
//
//  Created by Raphaël Payet on 28/09/2023.
//

import SwiftUI

extension View {
    func fullWidth(_ alignment: Alignment = .leading) -> some View {
        self
            .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: alignment
            )
    }
}
