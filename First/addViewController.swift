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
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func addInfo(_ sender: Any){
        globalVariable.nameArray.append(nameText.text!)
        globalVariable.emailArray.append(emailText.text!)
        print(globalVariable.nameArray)
        print(globalVariable.emailArray)
        UserDefaults.standard.set(globalVariable.nameArray, forKey: "nameKey")
        UserDefaults.standard.set(globalVariable.emailArray, forKey: "emailKey")
    }
    
    struct globalVariable{
        //static var nameArray = ["MOD"]
        //static var emailArray = ["mod@southkentschool.org"]
        static var nameArray = UserDefaults.standard.object(forKey: "nameKey") as! Array<Any>
        static var emailArray = UserDefaults.standard.object(forKey: "emailKey") as! Array<Any>
    }
    
    @IBAction func cleanInfo(_ sender: Any) {
        UserDefaults.standard.set(["MOD"], forKey: "nameKey")
        UserDefaults.standard.set(["mod@southkentschool.org"], forKey: "emailKey")
        globalVariable.nameArray = ["MOD"]
        globalVariable.emailArray = ["mod@southkentschool.org"]
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

