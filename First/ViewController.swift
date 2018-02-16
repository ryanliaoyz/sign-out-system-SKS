//
//  ViewController.swift
//  First
//
//  Created by Ryan Liao on 2/5/18.
//  Copyright © 2018 Ryan Liao. All rights reserved.
//


import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row] as? String
    }

    
    @IBOutlet weak var picker: UIPickerView!
    
    

    var pickerData: Array<Any> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        
        // Input data into the Array:
        pickerData = addViewController.globalVariable.nameArray
        
        
        
    }
    


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
    }
        
    
    
}
