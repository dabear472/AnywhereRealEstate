//
//  NetworkTraffic.swift
//  Anywhere Real Estate
//
//  Created by Jonathan Buford on 11/20/22.
//

import UIKit
import Foundation

class NetworkTraffic: NSObject {
    var decodedData:[FirstCallDataModel]?
    var imageSrc: String?
    let group = DispatchGroup()

    static let shared = NetworkTraffic()
    
    override init(){}

    func gatherData(withSimpsons:Bool) {
        var requestString: URL = URL(string: "www.yahoo.com")!
        if withSimpsons {
            requestString = URL(string: GlobalVariables.networkSimpsonsURL)!
        } else {
            /// If the app is not calling for Simpsons characters, then it is assumed that it is calling for Wire characters.
            requestString = URL(string: GlobalVariables.networkWireURL)!
        }
        var request = URLRequest(url: requestString)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let topLevelData = try! decoder.decode(FirstCallTopLevelData?.self, from: data) {
                    self.decodedData = topLevelData.RelatedTopics
                    print("Valid response for name data received and decoded.")
                } else {
                    print("Invalid response recieved for data.")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
            let passData:[String: [FirstCallDataModel]?] = ["decodedData": self.decodedData]
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "decodedDataReceived"),
                                                object: nil,
                                                userInfo: passData as [AnyHashable : Any])
            }
        }
        task.resume()

    }

    func gatherImageData(withImageView: UIImageView,
                         withQueryName: String) {
        if let query = withQueryName.addingPercentEncoding(withAllowedCharacters: .allowedCharacters) {
            let requestString = "https://customsearch.googleapis.com/customsearch/v1?key=AIzaSyCCwe1rNj4lILU2AbbiBE1ttz1BgNWL_O4&cx=748f591eb2c414397&q=\(query)&SearchType=%22image%22"
            guard let requestURL = URL(string: requestString) else { return }
            var request = URLRequest(url: requestURL)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    if let topLevelData = try! decoder.decode(SecondCallTopLevelData?.self, from: data) {
                        print("Valid response for image data received and decoded.")
                        var imageSrcAvailable: Bool = false
                        for item in topLevelData.items {
                            if let imageSrcCheck = item.pagemap.cse_thumbnail?[0].src {
                                self.imageSrc = imageSrcCheck
                                imageSrcAvailable = true
                                print("Image source found")
                                break
                            } else {
                                DispatchQueue.main.async {
                                    withImageView.image = GlobalVariables.noImageIcon
                                }
                            }
                        }
                        if imageSrcAvailable {
                            self.getImageNetworkCall(withImageView: withImageView)
                        }
                    } else {
                        print("Invalid response recieved for image source data.")
                    }
                } else if let error = error {
                    print("HTTP Request Failed \(error)")
                }
            }
            task.resume()
        }

    }

    func getImageNetworkCall(withImageView: UIImageView) {
        if let imageSrcFound = self.imageSrc {
            guard let requestImageURL = URL(string: imageSrcFound) else { return }
            let request = URLRequest(url: requestImageURL)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        withImageView.image = UIImage(data: data)
                    }
                } else if let error = error {
                    print("HTTP Request Failed \(error)")
                }
            }
            task.resume()
        }
    }
}

extension CharacterSet {
    static let allowedCharacters = urlQueryAllowed.subtracting(.init(charactersIn: "+ "))
}
