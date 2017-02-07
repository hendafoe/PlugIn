//
//  AddPartyViewController.swift
//  PlugIn
//
//  Created by Henry Dafoe on 11/1/16.
//  Copyright © 2016 Henry Dafoe. All rights reserved.
//

import UIKit

class AddPartyViewController: UIViewController {
    @IBOutlet weak var partyName: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func AddParty(_ sender: AnyObject) {
        //Add Party
        let name = partyName.text
        let postString = "a=\(name)"
        let request = NSMutableURLRequest(url: URL(string: "http://pluginstreaming.com/insertParty.php")!)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: String.Encoding.utf8);
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main)
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
        
        //Get party info
        var partyID = 0
        let myURLString = "http://pluginstreaming.com/retrieveLastParty.php"
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }
        
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            partyID = Int(myHTMLString)!
            
        } catch let error {
            print("Error: \(error)")
        }
        
        print(User.userID)
        let userID = User.userID
        let postString2 = "a=\(partyID)&b=\(userID)&c=1"
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
