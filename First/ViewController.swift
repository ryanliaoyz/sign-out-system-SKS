//
//  ViewController.swift
//  First
//
//  Created by Ryan Liao on 2/5/18.
//  Copyright © 2018 Ryan Liao. All rights reserved.
//


import UIKit
import MessageUI

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, MFMailComposeViewControllerDelegate, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row] as? String
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        addViewController.globalVariable.emailAddress = [addViewController.globalVariable.emailArray[row] as! String]
    }
    
    @IBOutlet weak var picker: UIPickerView!
    
    
    @IBAction func test(_ sender: Any) {
        print(addViewController.globalVariable.emailAddress)
        print(addViewController.globalVariable.emailArray)
        print(addViewController.globalVariable.nameArray)
    }
    
    var pickerData: Array<Any> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        
        // Input data into the Array:
        pickerData = addViewController.globalVariable.nameArray
        
        self.contentText.delegate=self
        self.nameText.delegate=self
        self.titleText.delegate=self
        
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
    mailComposerVC.setToRecipients(addViewController.globalVariable.emailAddress)
        mailComposerVC.setSubject(titleText.text!)

        mailComposerVC.setMessageBody("\(contentText.text!)\n\n\(nameText.text!)", isHTML: false)
        
        return mailComposerVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "Could not send", message: "couldn't", preferredStyle: .alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
 
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var contentText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contentText.resignFirstResponder()
        nameText.resignFirstResponder()
        titleText.resignFirstResponder()
        return true
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
    }
    
    
}


