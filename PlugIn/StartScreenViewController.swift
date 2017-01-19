//
//  StartScreenViewController.swift
//  PlugIn
//
//  Created by Will Lazebnik on 1/18/17.
//  Copyright © 2017 Henry Dafoe. All rights reserved.
//

import UIKit

struct User {
    let userID: Int
}

class StartScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        var deviceExists = ""
        let myURLString = "http://pluginstreaming.com/checkForDevice.php?a=" + deviceID
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }
        
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            print(myHTMLString)
            deviceExists = myHTMLString
        } catch let error {
            print("Error: \(error)")
        }
        
        if(deviceExists == "true"){
            let secondViewController = self.storyboard.instantiateViewControllerWithIdentifier("SecondViewController") as SecondViewController
            self.navigationController.pushViewController(secondViewController, animated: true)
        }
        else{
            let secondViewController = self.storyboard.instantiateViewControllerWithIdentifier("SecondViewController") as SecondViewController
            self.navigationController.pushViewController(secondViewController, animated: true)
            
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
