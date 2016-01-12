//
//  ViewController.swift
//  OnlineTalking
//
//  Created by YeoHuang on 16/1/12.
//  Copyright © 2016年 YeoHuang. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

  @IBOutlet weak var entrySubVCBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginAction(sender: AnyObject) {
        let dic = [
            "username": "admin",
            "password": "sjtu2011"
        ]
        request(.POST, "http://api.careerfrog.cn/api/user/authentication", parameters: dic, encoding: .JSON, headers: nil).responseJSON() {
            response in
            guard response.result.isSuccess == true,
              let responseDic = response.result.value as? [String: AnyObject]
            else { return }
            
          guard let status = responseDic["status"] as? String where (status == "SUCCESS")
          else { return }
          
          debugPrint("登陆成功")

        }
    }
  
  @IBAction func entrySubVC(sender: AnyObject) {
    
  }
    
}






