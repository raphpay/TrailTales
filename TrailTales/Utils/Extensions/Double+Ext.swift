//
//  Double+Ext.swift
//  TrailTales
//
//  Created by Raphaël Payet on 21/09/2023.
//

import Foundation

class Utils {
    static func getDurationInS(hours: Double, minutes: Double) -> Double {
        (hours * 3600) + (minutes * 60)
    }
}
