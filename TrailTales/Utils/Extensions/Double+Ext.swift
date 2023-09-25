//
//  Double+Ext.swift
//  TrailTales
//
//  Created by Raphaël Payet on 21/09/2023.
//

import Foundation

extension Double {
    func formatDuration() -> String {
        let duration = Int(self)
        let secondsInMinute = 60
        let secondsInHour = 3600
        let secondsInDay = 86400

        if duration >= secondsInDay {
            let days = duration / secondsInDay
            return "\(days) day\(days > 1 ? "s" : "")"
        } else if duration >= secondsInHour {
            let hours = duration / secondsInHour
            return "\(hours) hour\(hours > 1 ? "s" : "")"
        } else if duration >= secondsInMinute {
            let minutes = duration / secondsInMinute
            return "\(minutes) minute\(minutes > 1 ? "s" : "")"
        } else {
            return "Less than a minute"
        }
    }
}
