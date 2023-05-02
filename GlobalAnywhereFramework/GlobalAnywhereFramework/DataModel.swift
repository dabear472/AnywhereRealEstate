//
//  DataModel.swift
//

import Foundation

struct FirstCallDataModel: Codable {
    
    // MARK: - Properties
    
    let FirstURL: String
    var Icon: IconData
    let Text: String
}

struct FirstCallTopLevelData: Codable {
    let RelatedTopics: [FirstCallDataModel]
}

struct IconData: Codable {
    let URL: String
}

struct SecondCallTopLevelData: Codable {
    let items: [SecondCallSecondLevelData]
}

struct SecondCallSecondLevelData: Codable {
    let pagemap: SecondCallThirdLevelData
}

struct SecondCallThirdLevelData: Codable {
    let cse_thumbnail: [SecondCallFourthLevelData]?
}

struct SecondCallFourthLevelData: Codable {
    let src: String?
}
