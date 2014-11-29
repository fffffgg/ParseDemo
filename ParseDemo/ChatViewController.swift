//
//  ChatViewController.swift
//  ParseDemo
//
//  Created by Deepak on 11/28/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//class ChatViewController: UIViewController {
    var messages: [PFObject] = [PFObject]()
    var currentUser: PFUser!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var chatText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.rowHeight = UITableViewAutomaticDimension
        chatTableView.estimatedRowHeight = UITableViewAutomaticDimension
        getMessages()
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onTimer", userInfo: nil, repeats: true)
        chatTableView.delegate = self
        chatTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSend(sender: AnyObject) {
                var message = PFObject(className: "Message")
                message["text"] = self.chatText.text
                message["user"] = _CurrentUser.username
                message.saveInBackgroundWithBlock { (succeeded: Bool!, error: NSError!) -> Void in
                    if error != nil {
                        println("error \(error)")
                    } else {
                        println("Message saved successfully!")
                    }
                }
        
    }

    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func onTimer() {
        // Add code to be run periodically
        //NSLog("Timer fired")
        getMessages()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ChatCell") as ChatCell
        var message = messages[indexPath.row]
        cell.chatText.text = message["text"] as? String
        cell.userNameText.text = message["user"] as? String
        return cell
    }
    
    func getMessages() {
        var query = PFQuery(className: "Message")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            self.messages = objects as [PFObject]
            self.chatTableView.reloadData()
        }
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
