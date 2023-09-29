//
//  UIImage+Ext.swift
//  TrailTales
//
//  Created by Raphaël Payet on 29/09/2023.
//

import UIKit

extension UIImage {
    // MARK: - UIImage+Resize
    func getCompressedData() -> Data? {
        let sizeInBytes = 1 * 1024 * 1024
        var needCompress:Bool = true
        var imageData:Data?
        var compressingValue:CGFloat = 1.0
        
        while (needCompress && compressingValue > 0.0) {
            if let data:Data = self.jpegData(compressionQuality: compressingValue) {
                if data.count < sizeInBytes {
                    needCompress = false
                    imageData = data
                } else {
                    compressingValue -= 0.1
                }
            }
        }

        return imageData
    }
}
