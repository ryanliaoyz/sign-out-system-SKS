//
//  addViewController.swift
//  First
//
//  Created by Ryan Liao on 2/15/18.
//  Copyright © 2018 Ryan Liao. All rights reserved.
//

import UIKit

class addViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var nameArray: [String] = []
    var emailArray: [String] = []
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func addInfo(_ sender: Any){
        var nameArray = UserDefaults.standard.object(forKey: "nameKey") as! Array<Any>
        var emailArray = UserDefaults.standard.object(forKey: "emailKey") as! Array<Any>
        nameArray.append(nameText.text!)
        emailArray.append(emailText.text!)
        print(nameArray)
        print(emailArray)
        UserDefaults.standard.set(nameArray, forKey: "nameKey")
        UserDefaults.standard.set(emailArray, forKey: "emailKey")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
