//
//  CityListTableViewController.swift
//  风生
//
//  Created by 覃红 on 2016/10/25.
//  Copyright © 2016年 hayleyqin. All rights reserved.
//

import UIKit
import Alamofire
import JSONNeverDie

class CityListTableViewController: UITableViewController {
    var cityList:[String] = []
    let requestURL = "https://api.heweather.com/x3/weather"
    var tmpList:[String] = []
    var tmpArr:[Int] = []
    
    @IBAction func addCity(_ sender: Any) {
        let alertController = UIAlertController(title: "添加城市",
                                                message: "请输入您要关注的城市", preferredStyle: .alert)
        
        
        alertController.addTextField { (UITextField) in
            UITextField.placeholder = "请输入城市名"
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default,
                                     handler: {
                                        action in
                                        let city = (alertController.textFields?.first)!
                                        self.cityList.append(city.text!)
                                        UserDefaults.standard.set(self.cityList, forKey: "city")
                                        self.tmpList.removeAll()
                                        self.tmpArr.removeAll()
                                        self.updateTmp()
                                        
        })
     
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
     
        if  UserDefaults.standard.object(forKey: "city") as? [String] == nil {
             UserDefaults.standard.set(self.cityList, forKey: "city")
        } else {
            self.cityList = UserDefaults.standard.object(forKey: "city") as! [String]
        }
        
        let uiView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        uiView.backgroundColor = UIColor.clear
        self.tableView.tableFooterView = uiView
        

        
        updateTmp()
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tmpList.removeAll()
        self.tmpArr.removeAll()
    }
    func updateTmp() {
        if cityList.count != 0 {
            for i in 0..<self.cityList.count {
             
                let parameters: Parameters = ["city": cityList[i], "key":"785b65cc83654963bd7ef0cf3864cdb5"]
                Alamofire.request(requestURL, method: .get, parameters: parameters).response { response in
                    let jsonString = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) as! String
                    let json = JSONND(string: jsonString)
                    let jsonArr = json["HeWeather data service 3.0"].arrayValue
                    if jsonArr.count > 0 {
                        self.tmpList.append(jsonArr[0]["now"]["tmp"].stringValue)
                        self.tmpArr.append(i)
                        if self.tmpArr.count == self.cityList.count{
                            self.tableView.reloadData()
                        }

                    }
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let parameters: Parameters = ["city": cityList[indexPath.row], "key":"785b65cc83654963bd7ef0cf3864cdb5"]
        Alamofire.request(requestURL, method: .get, parameters: parameters).response { response in
            let jsonString = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) as! String
            let json = JSONND(string: jsonString)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotificationIdentifier"), object: json)

        }
        
        
        
    
       _ = self.navigationController?.popViewController(animated: true)

 
  
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let cityL = cell.contentView.viewWithTag(1) as! UILabel
        let weatherL = cell.contentView.viewWithTag(2) as! UILabel
         
        cityL.text = cityList[indexPath.row]
        if self.tmpList.count != 0 {
            //tmpArr的值为异步加载后的理论显示顺序，所以通过tmpArr的索引即可知道tmpList该先显示的顺序
            weatherL.text = "\(tmpList[self.tmpArr.index(of: indexPath.row)!])°"

        }
        return cell

    }
    //删除对应的城市
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            self.cityList.remove(at: indexPath.row)
            self.tmpList.remove(at: indexPath.row)
            self.tmpArr.remove(at: indexPath.row)
            //tableView.reloadData()
            UserDefaults.standard.set(self.cityList, forKey: "city")
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    
    //删除按钮的文字
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
         return "删除"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cityList.count
    }

 
}
