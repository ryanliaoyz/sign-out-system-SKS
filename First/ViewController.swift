//
//  ViewController.swift
//  First
//
//  Created by Ryan Liao on 2/5/18.
//  Copyright © 2018 Ryan Liao. All rights reserved.
//


import UIKit
import MessageUI

//  self
class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, MFMailComposeViewControllerDelegate, UITextFieldDelegate {
    
//  ViewController  Property
    var pickerData: Array<[String: String]> = []
    var emailAddress: String = "mod@southkentschool.org"
    var emailInfo = [String : String]()
    
//  self  Components
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var contentText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    
//  self Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        
        // Input data into the Array:
        self.contentText.delegate=self
        self.nameText.delegate=self
        self.titleText.delegate=self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadDataAndRefresh()
        picker.selectRow(0, inComponent: 0, animated: true)
    }
    
//  pickerView delegate & pickerView dataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var contactInfo: [String: String] = pickerData[row]
        let contactName = contactInfo["nameKey"]
        return contactName
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var contactInfo: [String: String] = pickerData[row]
        let contactEmail = contactInfo["emailKey"]
        emailAddress = contactEmail!
        emailLabel.text = emailAddress
    }
    
//  textField delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //        nameText.resignFirstResponder()
        //        titleText.resignFirstResponder()
        //        contentText.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.view.frame.origin.y = -100
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.view.frame.origin.y = 0
        }
    }
    
//  self   Actions
    // Test Button Click
    @IBAction func test(_ sender: Any) {
        // print(UserDefaults.standard.array(forKey: "contacts"))
        // print(UserDefaults.standard.array(forKey: "emails"))
        print(emailAddress)
    }
    
    //  jump SentListViewController With Identifier in Storyboard
    @IBAction func jumpSentListWithCallback(_ sender: UIButton) {
        let SentListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SentListVC") as! SentListController
        //  Closure
        SentListVC.resultInfo = {
            (emailStr, titleStr, contentStr)-> Void in
            //  print(emailStr!, titleStr!, contentStr!)
            self.emailAddress = emailStr!
            self.emailLabel.text = emailStr!
            self.titleText.text = titleStr!
            self.contentText.text = contentStr!
        }
        self.present(SentListVC, animated: true) {}
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        mailComposerVC.setToRecipients([emailAddress])
        mailComposerVC.setSubject(titleText.text!)
        mailComposerVC.setMessageBody("\(contentText.text!)\n\n\(nameText.text!)", isHTML: false)
        emailInfo = ["emailAddress": emailAddress, "title": titleText.text!, "content": contentText.text!]
        
        return mailComposerVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true) {
            // controller.dismiss callback
            if result == MFMailComposeResult.sent {
                // send successed
                self.titleText.text = "Sign me out"
                self.nameText.text = ""
                self.contentText.text = ""
                var emails = UserDefaults.standard.array(forKey: "emails")
                if emails == nil {
                    emails = []
                }
                emails?.append(self.emailInfo)
                UserDefaults.standard.set(emails! as Array<AnyObject>, forKey: "emails")
                
            } else if result == MFMailComposeResult.cancelled {
                // send cancel
                print("cancel")
            }
        }
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "Could not send", message: "couldn't", preferredStyle: .alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    //  refresh all row in picker
    func reloadDataAndRefresh() -> () {
        pickerData = UserDefaults.standard.array(forKey: "contacts")! as! Array<[String : String]>
        picker.reloadAllComponents()
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
    }
}


