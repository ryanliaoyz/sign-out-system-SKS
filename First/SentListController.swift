//
//  SentListController.swift
//  First
//
//  Created by Jo Liao on 2018/3/13.
//  Copyright © 2018年 Ryan Liao. All rights reserved.
//

import UIKit

//  self
class SentListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
//  Closure
    typealias InfoClosure = (_ emailAddress: String?, _ title: String?, _ content: String?) -> Void
    
//  SentListVC Property
    var list: Array<[String: String]> = []
    var resultInfo: InfoClosure?
    
//  self Components
    @IBOutlet weak var sentListTableView: UITableView!
    
//  self Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        sentListTableView.dataSource = self
        sentListTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadDataAndRefresh()
    }

//  tableView dataSource & tableView delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sentCell")!
        let emailInfo = list[indexPath.row]
        cell.textLabel?.text = emailInfo["emailAddress"]
        cell.detailTextLabel?.text = emailInfo["title"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete && indexPath.row != 0 {
            list.remove(at: indexPath.row)
            //  refresh current row in tableview & update with UserDefaults forKey "emails"
            UserDefaults.standard.set(list as Array<AnyObject>, forKey: "emails")
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let emailInfo = list[indexPath.row]
        let emailAddress = emailInfo["emailAddress"]
        let title = emailInfo["title"]
        let content = emailInfo["content"]
        
        if resultInfo != nil {
            resultInfo!(emailAddress!, title!, content!)
            // goBack
            self.dismiss(animated: true, completion: {})
        }
    }
    
    
//  self Actions
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // refresh all row in tableView
    func reloadDataAndRefresh() -> () {
        list = UserDefaults.standard.array(forKey: "emails") as! Array<[String : String]>
        //  print(data)
        sentListTableView.reloadData();
    }
    
}
