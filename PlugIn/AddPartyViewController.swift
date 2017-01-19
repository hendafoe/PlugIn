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
