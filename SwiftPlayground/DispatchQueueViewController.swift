//
//  DispatchQueueViewController.swift
//  SwiftPlayground
//
//  Created by s.wakasugi on 2022/07/29.
//

import Foundation
import UIKit
import Alamofire

struct ForecastResponse: Decodable {
    let title: String
    let forecasts: [Forecast]
    
    struct Forecast: Decodable {
        let date: String
        let telop: String
    }
}

class DispatchQueueViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var forecastStrings: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cityIDs: [String] = ["011000", "012010", "012020", "013010", "013020", "013030", "014010", "014020", "014030", "015010", "015020", "016010", "016020", "016030", "017010", "017020"]
        getForecastAPIs(cityIDs: cityIDs) {
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }
        
    }
    
    func getForecastAPIs(cityIDs: [String], completion: @escaping (() -> Void)) {
        let dispatchQueue = DispatchQueue.global()
        let dispatchGroup = DispatchGroup()
        dispatchQueue.async {
            // globalキュー
            cityIDs.enumerated().forEach ( { (index, cityID) in
                dispatchGroup.enter()
                self.getForecastAPI(cityID: cityID) { forecastResponse in
                    // mainキュー
                    self.forecastStrings.append(String(index) + forecastResponse.title + " は " + forecastResponse.forecasts[0].telop)
                    dispatchGroup.leave()
                }
                // globalキュー
                dispatchGroup.wait()
            })
            // globalキュー
            DispatchQueue.main.async {
                // mainキュー(画面を触るのでmainである必要がある)
                completion()
            }
        }
    }
    
    func getForecastAPI(cityID: String, completion: @escaping ((ForecastResponse) -> Void)) {
        // globalキュー
        AF.request("https://weather.tsukumijima.net/api/forecast/city/\(cityID)").responseDecodable(of: ForecastResponse.self, decoder: JSONDecoder()) { forecastResponse in
            // mainキュー(Alamofireの仕様)
            switch forecastResponse.result {
            case .success(let response):
                completion(response)
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension DispatchQueueViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastStrings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text =  forecastStrings[indexPath.row]
        return cell
    }
}
