//
//  StartScreenViewController.swift
//  PlugIn
//
//  Created by Will Lazebnik on 1/18/17.
//  Copyright © 2017 Henry Dafoe. All rights reserved.
//

import UIKit

struct User {
    static var userID = 0
    
    static func removeOptional(input: String) -> String
    {
        let start = input.index(input.startIndex, offsetBy: 10)
        let end = input.index(input.endIndex, offsetBy: -2)
        let range = start..<end
        
        var removed = input.substring(with: range)
        print(removed)
        return removed
    }
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
            print("lets go")
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        else{
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
            self.navigationController?.pushViewController(secondViewController, animated: true)
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
