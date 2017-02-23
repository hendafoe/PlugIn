//
//  InviteTableViewCell.swift
//  PlugIn
//
//  Created by Will Lazebnik on 2/7/17.
//  Copyright © 2017 Henry Dafoe. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet var acceptButton: UIButton!
    @IBOutlet var declineButton: UIButton!
    @IBOutlet var cellTitle: UILabel!
    @IBOutlet var tableView: UITableView!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func acceptAction(_ sender: AnyObject) {
        
        print(sender.tag)
        //Insert into party
        let myURLString3 = "http://pluginstreaming.com/retrievePartyFromInvite.php?a=" + String(sender.tag)
        var myHTMLString3 = ""
        guard let myURL3 = URL(string: myURLString3) else {
            print("Error: \(myURLString3) doesn't seem to be a valid URL")
            return
        }
        
        do {
            myHTMLString3 = try String(contentsOf: myURL3, encoding: .ascii)
        } catch let error {
            print("Error: \(error)")
        }
        
        let userID = User.userID
        print("")
        print("Values:")
        print("User: " + String(userID))
        print("Party: " + String(myHTMLString3))
        print("InviteID: " + String(sender.tag))
        print("")
        let postString2 = "a=\(myHTMLString3)&b=\(userID)&c=0"
        print(postString2)
        let request2 = NSMutableURLRequest(url: URL(string: "http://pluginstreaming.com/insertUserPartyRelation.php")!)
        request2.httpMethod = "POST"
        request2.httpBody = postString2.data(using: String.Encoding.utf8);
        NSURLConnection.sendAsynchronousRequest(request2 as URLRequest, queue: OperationQueue.main)
        {
            (response, data, error) in
            print(response)
            if let HTTPResponse = response as? HTTPURLResponse {
                let statusCode = HTTPResponse.statusCode
                if statusCode == 200 {
                    print("Insert successful")
                }
            }
        }

        
        let myURLString2 = "http://pluginstreaming.com/deleteInvite.php?a=" + String(sender.tag)
        guard let myURL2 = URL(string: myURLString2) else {
            print("Error: \(myURLString2) doesn't seem to be a valid URL")
            return
        }
        
        do {
            let myHTMLString2 = try String(contentsOf: myURL2, encoding: .ascii)
            print(myHTMLString2)
            self.tableView?.reloadData()
        }
        catch let error {
            print("Error: \(error)")
        }
        
        
        
        

    }
    @IBAction func declineAction(_ sender: AnyObject) {
        print(sender.tag)
        
        let myURLString2 = "http://pluginstreaming.com/deleteInvite.php?a=" + String(sender.tag)
        guard let myURL2 = URL(string: myURLString2) else {
            print("Error: \(myURLString2) doesn't seem to be a valid URL")
            return
        }
        
        do {
            let myHTMLString2 = try String(contentsOf: myURL2, encoding: .ascii)
            print(myHTMLString2)
            self.tableView?.reloadData()
        }
        catch let error {
            print("Error: \(error)")
        }

    }

}
