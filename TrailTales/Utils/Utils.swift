//
//  Utils.swift
//  TrailTales
//
//  Created by Raphaël Payet on 25/09/2023.
//

import Foundation

class Utils {
    static func convertToSeconds(days: Int = 0, hours: Int, minutes: Int) -> Double {
        let secondsInMinute = 60
        let secondsInHour = 3600
        let secondsInDay = 86400

        let totalSeconds = Double(days * secondsInDay + hours * secondsInHour + minutes * secondsInMinute)
        
        return totalSeconds
    }
}
