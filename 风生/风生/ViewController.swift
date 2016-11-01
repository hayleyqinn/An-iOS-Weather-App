//
//  ViewController.swift
//  风生
//
//  Created by 覃红 on 2016/10/22.
//  Copyright © 2016年 hayleyqin. All rights reserved.
//

import UIKit
import JSONNeverDie
import Alamofire
import WechatKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, WechatManagerShareDelegate {
    @IBOutlet weak var forecastT: UITableView!
    @IBOutlet weak var cityN: UILabel!
    @IBOutlet weak var aqi: UILabel!
    @IBOutlet weak var tem: UILabel!
    @IBOutlet weak var updateTime: UILabel!
    @IBOutlet weak var aqiDes: UILabel!
    @IBOutlet weak var con: UILabel!
    @IBOutlet weak var conImage: UIImageView!
    @IBOutlet weak var confO: UIButton!
    @IBOutlet weak var conT: UILabel!
    @IBOutlet weak var sportT: UILabel!
    @IBOutlet weak var uvT: UILabel!
    @IBOutlet weak var comT: UILabel!
    @IBOutlet weak var carT: UILabel!
    @IBOutlet weak var sportO: UIButton!
    @IBOutlet weak var uvO: UIButton!
    @IBOutlet weak var comO: UIButton!
    @IBOutlet weak var carO: UIButton!
    
    var suggestions: [String] = []
    var isDisplaySug: [Bool] = []
    var dateList:[String] = []
    var conList:[String] = []
    var temrList:[String] = []
    
    @IBAction func shareBT(_ sender: Any) {
        //exinfo is determine to return previousely app
        let optionMenu = UIAlertController(title: "分享天气", message: "请选择要分享的平台", preferredStyle: .actionSheet)
        let wechatAction = UIAlertAction(title: "微信好友", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            if self.suggestions.count > 0 {
                
                WechatManager.sharedInstance.share(WXSceneSession, image: self.conImage.image, title: "\(self.cityN.text!)\(self.con.text!)", description: self.suggestions[4], url: "http://php.weather.sina.com.cn/search.php?f=1&c=1&city=\(self.cityN.text!)&dpc=1", extInfo: nil)

            }
        })
     
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        optionMenu.addAction(wechatAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
  
    }
  
    func showMessage(_ message: String) {
            print(message)
    }
    @IBAction func carA(_ sender: Any) {
        if self.suggestions.count != 0{
            
            let sug = UITextView(frame: CGRect(x: carO.frame.origin.x -  22, y: 500, width: 70, height: 110))
            sug.text = suggestions[0]
            sug.isEditable = false
            sug.tag = 5
            sug.isSelectable = false
            sug.layer.cornerRadius = 10
            sug.backgroundColor = UIColor(red: 213/255, green: 239/255, blue: 236/255, alpha: 1)
            if !self.isDisplaySug[4]   {
                //清楚非现在点击的其他已经弹出的视图
                for i in 0..<5 {
                    if self.isDisplaySug[i] == true && i != 4{
                        for j in  self.view.subviews{
                            if j.tag == i + 1 {
                                j.removeFromSuperview()
                            }
                        }
                        self.isDisplaySug[i] = false
                    }
                }
                //弹出视图
                self.view.addSubview(sug)
                sug.layer.setAffineTransform(CGAffineTransform(scaleX: 0.1,y: 0.1))
                UIView.animate(withDuration: 0.1, delay: 0,
                               options:UIViewAnimationOptions.transitionFlipFromBottom, animations:
                    {
                        ()-> Void in
                        sug.layer.setAffineTransform(CGAffineTransform(scaleX: 1,y: 1))
                },
                               completion:{
                                (finished:Bool) -> Void in
                                UIView.animate(withDuration: 0.08, animations:{
                                    ()-> Void in
                                    sug.layer.setAffineTransform(CGAffineTransform.identity)
                                })
                })
                isDisplaySug[4] = true
            } else {
                //remove the sug when tap the icon again
                for i in  self.view.subviews{
                    if i.tag == 5 {
                        i.removeFromSuperview()
                    }
                }
                isDisplaySug[4] = false
            }
        }
    }
   
    @IBAction func conT(_ sender: Any) {
        
        if self.suggestions.count != 0{
            let sug = UITextView(frame: CGRect(x: (carO.frame.origin.x + uvO.frame.origin.x) / 2 - 10, y: 500, width: 70, height: 110))
            sug.text = suggestions[1]
            sug.isEditable = false
            sug.tag = 4
            sug.isSelectable = false
            sug.layer.cornerRadius = 10
            sug.backgroundColor = UIColor(red: 213/255, green: 239/255, blue: 236/255, alpha: 1)
            if !self.isDisplaySug[3]   {
                //清楚非现在点击的其他已经弹出的视图
                for i in 0..<5 {
                    if self.isDisplaySug[i] == true && i != 3{
                        for j in  self.view.subviews{
                            if j.tag == i + 1 {
                                j.removeFromSuperview()
                            }
                        }
                        self.isDisplaySug[i] = false
                    }
                }
                //弹出视图
                self.view.addSubview(sug)
                sug.layer.setAffineTransform(CGAffineTransform(scaleX: 0.1,y: 0.1))
                UIView.animate(withDuration: 0.1, delay: 0,
                               options:UIViewAnimationOptions.transitionFlipFromBottom, animations:
                    {
                        ()-> Void in
                        sug.layer.setAffineTransform(CGAffineTransform(scaleX: 1,y: 1))
                },
                               completion:{
                                (finished:Bool) -> Void in
                                UIView.animate(withDuration: 0.08, animations:{
                                    ()-> Void in
                                    sug.layer.setAffineTransform(CGAffineTransform.identity)
                                })
                })
                isDisplaySug[3] = true
            } else {
                //remove the sug when tap the icon again
                for i in  self.view.subviews{
                    if i.tag == 4 {
                        i.removeFromSuperview()
                    }
                }
                isDisplaySug[3] = false
            }
            
        }
        
    }

    @IBAction func uvA(_ sender: Any) {
        if self.suggestions.count != 0{
        
            let sug = UITextView(frame: CGRect(x: (self.comO.frame.origin.x + self.sportO.frame.origin.x) / 2 - 20, y: 500, width: 70, height: 110))
            sug.text = suggestions[2]
            sug.isEditable = false
            sug.tag = 3
            sug.isSelectable = false
            sug.layer.cornerRadius = 10
            sug.backgroundColor = UIColor(red: 213/255, green: 239/255, blue: 236/255, alpha: 1)
            if !self.isDisplaySug[2]   {
                //清楚非现在点击的其他已经弹出的视图
                for i in 0..<5 {
                    if self.isDisplaySug[i] == true && i != 2{
                        for j in  self.view.subviews{
                            if j.tag == i + 1 {
                                j.removeFromSuperview()
                            }
                        }
                        self.isDisplaySug[i] = false
                    }
                }
                //弹出视图
                self.view.addSubview(sug)
                sug.layer.setAffineTransform(CGAffineTransform(scaleX: 0.1,y: 0.1))
                UIView.animate(withDuration: 0.1, delay: 0,
                               options:UIViewAnimationOptions.transitionFlipFromBottom, animations:
                    {
                        ()-> Void in
                        sug.layer.setAffineTransform(CGAffineTransform(scaleX: 1,y: 1))
                },
                               completion:{
                                (finished:Bool) -> Void in
                                UIView.animate(withDuration: 0.08, animations:{
                                    ()-> Void in
                                    sug.layer.setAffineTransform(CGAffineTransform.identity)
                                })
                })
                isDisplaySug[2] = true
            } else {
                //remove the sug when tap the icon again
                for i in  self.view.subviews{
                    if i.tag == 3 {
                        i.removeFromSuperview()
                    }
                }
                isDisplaySug[2] = false
            }

        }
    }
    
    @IBAction func comA(_ sender: Any) {
        if self.suggestions.count != 0{
        
            let sug = UITextView(frame: CGRect(x: 15, y: 500, width: 70, height: 110))
            sug.text = suggestions[4]
            sug.isEditable = false
            sug.tag = 1
            sug.isSelectable = false
            sug.layer.cornerRadius = 10
            sug.backgroundColor = UIColor(red: 213/255, green: 239/255, blue: 236/255, alpha: 1)
            if !self.isDisplaySug[0]   {
                //清楚非现在点击的其他已经弹出的视图
                for i in 0..<5 {
                    if self.isDisplaySug[i] == true && i != 0{
                        for j in  self.view.subviews{
                            if j.tag == i + 1 {
                                j.removeFromSuperview()
                            }
                        }
                        self.isDisplaySug[i] = false
                    }
                }
                //弹出视图
                self.view.addSubview(sug)
                sug.layer.setAffineTransform(CGAffineTransform(scaleX: 0.1,y: 0.1))
                UIView.animate(withDuration: 0.1, delay: 0,
                               options:UIViewAnimationOptions.transitionFlipFromBottom, animations:
                    {
                        ()-> Void in
                        sug.layer.setAffineTransform(CGAffineTransform(scaleX: 1,y: 1))
                },
                               completion:{
                                (finished:Bool) -> Void in
                                UIView.animate(withDuration: 0.08, animations:{
                                    ()-> Void in
                                    sug.layer.setAffineTransform(CGAffineTransform.identity)
                                })
                })
                isDisplaySug[0] = true
            } else {
                //remove the sug when tap the icon again
                for i in  self.view.subviews{
                    if i.tag == 1 {
                        i.removeFromSuperview()
                    }
                }
                isDisplaySug[0] = false
            }
        }
    }
    
    @IBAction func sportA(_ sender: Any) {
        if self.suggestions.count != 0{
        
            let sug = UITextView(frame: CGRect(x: (self.uvO.frame.origin.x - self.confO.frame.origin.x) / 2 - 5, y: 500, width: 70, height: 110))
            sug.text = suggestions[3]
            sug.isEditable = false
            sug.tag = 2
            sug.isSelectable = false
            sug.layer.cornerRadius = 10
            sug.backgroundColor = UIColor(red: 213/255, green: 239/255, blue: 236/255, alpha: 1)
            
            if !self.isDisplaySug[1]   {
                //清楚非现在点击的其他已经弹出的视图
                for i in 0..<5 {
                    if self.isDisplaySug[i] == true && i != 1{
                        for j in  self.view.subviews{
                            if j.tag == i + 1 {
                                j.removeFromSuperview()
                            }
                        }
                        self.isDisplaySug[i] = false
                    }
                }
                //弹出视图
                self.view.addSubview(sug)
                sug.layer.setAffineTransform(CGAffineTransform(scaleX: 0.1,y: 0.1))
                UIView.animate(withDuration: 0.1, delay: 0,
                               options:UIViewAnimationOptions.transitionFlipFromBottom, animations:
                    {
                        ()-> Void in
                        sug.layer.setAffineTransform(CGAffineTransform(scaleX: 1,y: 1))
                },
                               completion:{
                                (finished:Bool) -> Void in
                                UIView.animate(withDuration: 0.08, animations:{
                                    ()-> Void in
                                    sug.layer.setAffineTransform(CGAffineTransform.identity)
                                })
                })
                isDisplaySug[1] = true
                
            } else {
                //remove the sug when tap the icon again
                for i in  self.view.subviews{
                    if i.tag == 2 {
                        i.removeFromSuperview()
                    }
                }
                isDisplaySug[1] = false
            }
        }
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        //调整导航栏颜色
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 153/255, blue: 170/255, alpha: 1)

        WechatManager.appid = "wxb624f521419b82a8"
        WechatManager.appSecret = "8bc62665998c981e844741513ad70e2e"
        WechatManager.sharedInstance.shareDelegate = self
        
        self.forecastT.delegate = self
        self.forecastT.dataSource = self
        self.isDisplaySug = [false, false, false, false, false]
  
        //init date
        initView()

        confO.isSelected  = false
        
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.disPlayMsg(notification:)), name: NSNotification.Name(rawValue: "NotificationIdentifier"), object: nil)
        
     
    }
    //初始化
    func initView(){
        let requestURL = "https://api.heweather.com/x3/weather"
        var latestC:String
        if UserDefaults.standard.object(forKey: "latestCity") as? String == nil {
            latestC = "珠海"
        } else {
            latestC = (UserDefaults.standard.object(forKey: "latestCity") as? String)!
        }
        
        let parameters: Parameters = ["city": latestC, "key":"785b65cc83654963bd7ef0cf3864cdb5"]
 
        Alamofire.request(requestURL, method: .get, parameters: parameters).response { response in
            let jsonString = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) as! String
            let json2 = JSONND(string: jsonString)
            self.updateView(json: json2)
        }
    }
    //更新视图
    func updateView(json:JSONND){
        let jsonArr = json["HeWeather data service 3.0"].arrayValue
       suggestions.removeAll()
        if jsonArr.count != 0 {
            //air condition
            self.aqi.text = jsonArr[0]["aqi"]["city"]["aqi"].stringValue
            self.aqiDes.text = jsonArr[0]["aqi"]["city"]["qlty"].stringValue
            if Int(self.aqi.text!)! < 80 {
                self.aqi.textColor = UIColor.green
                self.aqiDes.textColor = UIColor.green
            } else {
                self.aqi.textColor = UIColor(red: 255/255, green: 103/255, blue: 0/255, alpha: 1)
                self.aqiDes.textColor = UIColor(red: 255/255, green: 103/255, blue: 0/255, alpha: 1)
            }
            //city
            self.cityN.text = jsonArr[0]["basic"]["city"].stringValue
            //record the city by this tap for next open app
            UserDefaults.standard.set(self.cityN.text, forKey: "latestCity")
            //update time
            var ut = jsonArr[0]["basic"]["update"]["loc"].stringValue
            ut = ut.substring(from: ut.index(ut.startIndex, offsetBy: 10))
            self.updateTime.text = "上次更新:\(ut)"
            //tem
            self.tem.text = jsonArr[0]["now"]["tmp"].stringValue
            if Int(self.tem.text!)! < 26 {
                self.tem.textColor = UIColor.gray
            } else {
                self.tem.textColor = UIColor.orange
            }
            
            //suggestion
            self.carT.text = jsonArr[0]["suggestion"]["cw"]["brf"].stringValue
            self.suggestions.append(jsonArr[0]["suggestion"]["cw"]["txt"].stringValue)
            
            self.comT.text = jsonArr[0]["suggestion"]["drsg"]["brf"].stringValue
            self.suggestions.append(jsonArr[0]["suggestion"]["drsg"]["txt"].stringValue)
            
            self.uvT.text = jsonArr[0]["suggestion"]["uv"]["brf"].stringValue
            self.suggestions.append(jsonArr[0]["suggestion"]["uv"]["txt"].stringValue)
            
            self.sportT.text = jsonArr[0]["suggestion"]["sport"]["brf"].stringValue
            self.suggestions.append(jsonArr[0]["suggestion"]["sport"]["txt"].stringValue)
            
            self.conT.text = jsonArr[0]["suggestion"]["comf"]["brf"].stringValue
            self.suggestions.append(jsonArr[0]["suggestion"]["comf"]["txt"].stringValue)
            //weather description
            self.con.text = jsonArr[0]["now"]["cond"]["txt"].stringValue
            switch self.con.text! {
            case "多云","阴":
                self.conImage.image = UIImage(named: "cloudy")
            case "阵雨":
                self.conImage.image = UIImage(named: "rain")
            case "晴":
                self.conImage.image = UIImage(named: "sunshine")
            default:
                break
            }
            //forecast
            let forecast = jsonArr[0]["daily_forecast"].arrayValue
            for i in 0..<7 {
                conList.append(forecast[i]["cond"]["txt_d"].stringValue)
                let fc = forecast[i]["date"].stringValue
                dateList.append(fc.substring(from: fc.index(fc.startIndex, offsetBy: 5)))
                temrList.append("\(forecast[i]["tmp"]["min"].stringValue)° ~ \(forecast[i]["tmp"]["max"].stringValue)°")
            }
        } else {
            print("no such city")
        }
        
        forecastT.reloadData()
    }
    //响应通知
    func disPlayMsg(notification:NSNotification){
        let json = notification.object as! JSONND
        updateView(json: json)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let date = cell.contentView.viewWithTag(1) as! UILabel
        let con = cell.contentView.viewWithTag(2) as! UILabel
        let temr = cell.contentView.viewWithTag(3) as! UILabel
        
        if conList.count > 0 {
            date.text = dateList[indexPath.row]
            con.text = conList[indexPath.row]
            temr.text = temrList[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        dateList.removeAll()
        conList.removeAll()
        temrList.removeAll()
        
        for i in  self.view.subviews{
            if i.tag == 1 || i.tag == 2 || i.tag == 3 || i.tag == 4 || i.tag == 5{
                i.removeFromSuperview()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

