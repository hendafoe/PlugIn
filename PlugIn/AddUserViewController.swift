//
//  AddUserViewController.swift
//  PlugIn
//
//  Created by Henry Dafoe on 11/1/16.
//  Copyright © 2016 Henry Dafoe. All rights reserved.
//

import UIKit

class AddUserViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addUser(_ sender: AnyObject) {
        let name = username.text
        let pass = password.text
        
        //Add User
        let postString = "a=\(name)&b=\(pass)"
        let request = NSMutableURLRequest(url: URL(string: "http://pluginstreaming.com/insert.php")!)
        
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
        var userID = 0
        
        //Get user info
        let myURLString = "http://pluginstreaming.com/retrieveLastUser.php"
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }
        
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            userID = Int(myHTMLString)!
        } catch let error {
            print("Error: \(error)")
        }
        
        //User.userID = 3
        
        
        
        
        
        
    
    
        //Register Device
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        let postString2 = "a=\(userID)&b=\(deviceID)"
        let request2 = NSMutableURLRequest(url: URL(string: "http://pluginstreaming.com/insertDevice.php")!)
    
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
