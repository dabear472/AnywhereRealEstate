//
//  GlobalVariables.swift
//  20230201-JonathanBuford-NYCSchools
//
//  Created by Jonathan Buford on 1/29/23.
//

import UIKit

class GlobalVariables: NSObject {
    static let networkSimpsonsURL = "https://api.duckduckgo.com/?q=simpsons+characters&format=json"
    static let networkWireURL = "https://api.duckduckgo.com/?q=the+wire+characters&format=json"
    static let noImageIcon: UIImage = UIImage(systemName: "person.crop.circle.fill")!
    /// I know this is safe to be treated as explicit as is a system symbol
    /// and it will always return an image.

    var dataModel: FirstCallDataModel?

    static let shared = GlobalVariables()
    
    override init(){}
}
