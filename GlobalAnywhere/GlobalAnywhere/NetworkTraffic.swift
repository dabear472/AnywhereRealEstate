//
//  NetworkTraffic.swift
//  Anywhere Real Estate
//
//  Created by Jonathan Buford on 11/20/22.
//

import UIKit
import Foundation

class NetworkTraffic: NSObject {
    var decodedData:[DataModel]?
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
                if let launches = try! decoder.decode([DataModel]?.self, from: data) {
                    print("Valid response for data received and decoded.")
                    self.decodedData = launches
//                    DispatchQueue.main.async {
//                        print("GCD group leaving")
//                        self.group.leave()   // <<----
//                    }
                } else {
                    print("Invalid response recieved for data.")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()

    }

    func gatherImageData(withImageView: UIImageView,
                         withFirstURL: String,
                         withIconURL: String) {
        var requestString: URL = URL(string: withFirstURL + withIconURL)!
        var request = URLRequest(url: requestString)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let image = UIImage(data: data){
                    withImageView.image = image
                    print("Valid response for image data received and decoded.")
                } else {
                    withImageView.image = GlobalVariables.noImageIcon
                    print("Image data is unavailable from server.")
                }
//                DispatchQueue.main.async {
//                    print("GCD group leaving")
//                    self.group.leave()   // <<----
//                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()

    }

//    func gatherSATStats() {
//        let requestString = URL(string: GlobalVariables.networkSATUrl)!
//        var request = URLRequest(url: requestString)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data {
//                let decoder = JSONDecoder()
//                if let decSATstats = try! decoder.decode([SATData]?.self, from: data) {
//                    print("Valid response for SAT data received and decoded.")
//                    self.decodedSATstats = decSATstats
//                    DispatchQueue.main.async {
//                        print("SAT GCD group")
//                        self.group.leave()   // <<----
//                    }
//                } else {
//                    print("Invalid response recieved for SAT data.")
//                }
//            } else if let error = error {
//                print("HTTP Request (SAT) Failed \(error)")
//            }
//        }
//        task.resume()
//    }
    
//    func combineData() {
//        if let decSchoolData = decodedSchoolData {
//            if let decSATdata = decodedSATstats {
//                for (index, _) in decSchoolData.enumerated() {
//                    for satDatForSchool in decSATdata {
//                        if decodedSchoolData![index].dbn == satDatForSchool.dbn {
//                            decodedSchoolData![index].num_of_sat_test_takers = satDatForSchool.num_of_sat_test_takers
//                            decodedSchoolData![index].sat_critical_reading_avg_score = satDatForSchool.sat_critical_reading_avg_score
//                            decodedSchoolData![index].sat_math_avg_score = satDatForSchool.sat_math_avg_score
//                            decodedSchoolData![index].sat_writing_avg_score = satDatForSchool.sat_writing_avg_score
//                        }
//                    }
//                }
//                DispatchQueue.main.async {
//                    self.group.leave()   // <<----
//                }
//            }
//        }
//    }
    
//    func handleNetworkCalls() {
//        group.enter()
//        self.gatherData()
//
////        group.enter()
////        self.gatherSATStats()
//
////        group.notify(queue: .main) {
////            self.group.enter()
////            self.combineData()
//
//        self.group.notify(queue: .main) {
//            let passData:[String: [DataModel]?] = ["decodedData": self.decodedData]
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "decodedDataReceived"),
//                                            object: nil,
//                                            userInfo: passData as [AnyHashable : Any])
//        }
////        }
//    }
}
