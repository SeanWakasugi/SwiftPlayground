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
    var forecasts: [Forecast]
    
    struct Forecast: Decodable {
        let date: String
        let telop: String
    }
}

class DispatchQueueViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var forecasts: [ForecastResponse.Forecast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getForecastAPI { forecastResponse in
            self.forecasts = forecastResponse.forecasts
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }
    }
    
    func getForecastAPI(completion: @escaping ((ForecastResponse) -> Void)) {
        AF.request("https://weather.tsukumijima.net/api/forecast/city/400040").responseDecodable(of: ForecastResponse.self, decoder: JSONDecoder()) { forecastResponse in
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
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = forecasts[indexPath.row].date + forecasts[indexPath.row].telop
        return cell
    }
}
