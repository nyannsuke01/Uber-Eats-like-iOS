//
//  ViewController.swift
//  UberEatsLike
//
//  Created by user on 2021/09/04.
//

import UIKit
import Alamofire
import SwiftyJSON




class ViewController: UIViewController {
    
    var restaurants = [RestaurantJSON]()
    let decoder: JSONDecoder = JSONDecoder()
    var restaurant1: Any = ""
    let titleList = ["おひつじ座", "おうし座", "ふたご座", "かに座", "しし座",
                       "おとめ座", "てんびん座", "さそり座", "いて座", "やぎ座",
                       "みずがめ座", "うお座"]
    
    @IBOutlet weak var fetchAPIButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAPIButton.layer.cornerRadius = 10.0
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.dataSource = self

        getArticles()

        self.tableView.register(UINib(nibName: "RestaurantTableViewCell", bundle: nil), forCellReuseIdentifier: "RestaurantTableViewCell")

    }
    
    private func getArticles() {
        AF.request("http://localhost:3000/api/v1/restaurants").responseJSON { response in
                 switch response.result {
                 case .success:
                     do {
                        print(response.result)
                        let restaurants = try? self.decoder.decode(RestaurantJSON.self, from: response.data!)
                        print(restaurants)
                        print(restaurants?.restaurants.count)
                        
                          
                        
                        //SwiftyJSONでParse
                        let json = try? JSON(data: response.data!)
                        let jsonData = json!["restaurants"][0]["name"]
                        print(type(of: jsonData))
                        self.restaurant1 = jsonData
                        print(jsonData)
//                        print(restaurants as Any)
                     } catch {
                         print("デコードに失敗しました")
                     }
                 case .failure(let error):
                     print("error", error)
                 }
             }
    }
        
    @IBAction func fetchAPIButton(_ sender: Any) {
        getArticles()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
      }

      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleList.count
      }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath ) as! RestaurantTableViewCell
        cell.titleLabel.text = self.titleList[indexPath.row]

        //cell.setCell(restaurant: restaurants[indexPath.row])
        return cell
      }
}

