//
//  DataModel.swift
//

import Foundation

struct DataModel: Codable {
    
    // MARK: - Properties
    
    let FirstURL: String
    var Icon: IconData
    let Text: String
}

struct IconData: Codable {
    let URL: String
}
