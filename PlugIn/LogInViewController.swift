//
//  LogInViewController.swift
//  PlugIn
//
//  Created by Will Lazebnik on 1/18/17.
//  Copyright © 2017 Henry Dafoe. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logIn(_ sender: AnyObject) {
        let myURLString = "http://pluginstreaming.com/retrieveUser.php?a=" + username.text! + "&b=" + password.text!
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }
        
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            if(myHTMLString != "0 results")
            {
                User.userID = Int(myHTMLString)!
            }
        } catch let error {
            print("Error: \(error)")
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
