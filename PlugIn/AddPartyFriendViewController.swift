//
//  AddPartyFriendViewController.swift
//  PlugIn
//
//  Created by Will Lazebnik on 1/31/17.
//  Copyright © 2017 Henry Dafoe. All rights reserved.
//

import UIKit

class AddPartyFriendViewController: UIViewController {
    var partyID = 0
    var user2 = ""
    @IBOutlet var userField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("party:" + String(partyID))
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onAdd(_ sender: AnyObject) {
        let myURLString = "http://pluginstreaming.com/retrieveUserID.php?a=" + userField.text!
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }
        
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            if(myHTMLString != "0 results")
            {
                user2 = myHTMLString
            }
        } catch let error {
            print("Error: \(error)")
        }
        
        
        //ADD TO INVITES
        let postString2 = "a=\(User.userID)&b=\(user2)&c=\(partyID)"
        let request2 = NSMutableURLRequest(url: URL(string: "http://pluginstreaming.com/insertInvite.php")!)
        
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
        
        self.performSegue(withIdentifier: "BackSegue", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BackSegue"
        {
            if let destinationVC = segue.destination as? PartyViewController {
                destinationVC.partyID = partyID
            }
        }
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
