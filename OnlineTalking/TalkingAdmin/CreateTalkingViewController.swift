//
//  CreateTalkingViewController.swift
//  OnlineTalking
//
//  Created by YeoHuang on 1/13/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit

class CreateTalkingViewController: UIViewController {

  @IBOutlet weak var companyIdTextField: UITextField!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var shortNameTextField: UITextField!
  @IBOutlet weak var beginTextField: UITextField!
  @IBOutlet weak var endTextField: UITextField!

  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.companyIdTextField.text = "376D71EA"
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}















