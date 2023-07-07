//
//  FileManager+DocumentsDirectory.swift
//  SnowSeeker
//
//  Created by Rishav Gupta on 07/07/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
