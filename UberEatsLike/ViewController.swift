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
    var restaurantsCount: Int = 3
    var restaurantsName: [String] = []
    var restaurantsList : [(name: String?, id: String?, fee: String?, timeRequierd: String?)] = []
    let decoder: JSONDecoder = JSONDecoder()
    
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

                        let json = try? self.decoder.decode(RestaurantJSON.self, from: response.data!)
                        if let restaurants = json?.restaurants {
                            self.restaurantsList.removeAll()
                            for i in restaurants {
                                if let name = i.name, let id = i.id , let fee = i.fee , let timeRequierd = i.timeRequired {
                                    let restaurant = (name,String(id),String(fee),String(timeRequierd))
                                    self.restaurantsList.append(restaurant)
                                }
                            }
                            self.tableView.reloadData()
                        }
                        //SwiftyJSONでParse
                        let swiftyJSON = try? JSON(data: response.data!)
                        let jsonData = swiftyJSON!["restaurants"][0]["name"]
                        print(type(of: jsonData))
                        print(jsonData)
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
        return restaurantsList.count
      }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath ) as! RestaurantTableViewCell
        cell.titleLabel.text = self.restaurantsList[indexPath.row].name
        cell.feeLabel.text = self.restaurantsList[indexPath.row].fee! + "円~"
        cell.timeRequiredLabel.text = self.restaurantsList[indexPath.row].timeRequierd! + "分"
        let image1: UIImage = UIImage(named:"restaurant-image\(indexPath.row)")!
        let resizeImage = image1.resized(toWidth: 90)
        cell.imageView?.image = resizeImage
        

        //cell.setCell(restaurant: restaurants[indexPath.row])
        return cell
      }
    
    //Cellが選択された際に呼び出されるdelegateメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //ハイライト解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        //SFSafariViewを開く
//        let safariViewController = SFSafariViewController(url: okashiList[indexPath.row].linl)

        //delegateの通知先を自分自身
//        safariViewController.delegate = self
        
        //SafariViewが開かれる
  //      present(safariViewController, animated: true, completion: nil)
        
    }
}

