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

struct TopLevelData: Codable {
    let RelatedTopics: [DataModel]
}

struct IconData: Codable {
    let URL: String
}
