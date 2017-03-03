//
//  AddSongViewController.swift
//  PlugIn
//
//  Created by Will Lazebnik on 2/27/17.
//  Copyright © 2017 Henry Dafoe. All rights reserved.
//

import UIKit

class AddSongViewController: UIViewController {

    @IBOutlet var songTitle: UITextField!
    var partyID = 0
    override func viewDidLoad() {
        super.viewDidLoad()

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

    @IBAction func addSong(_ sender: AnyObject) {
        
        //Get song id
        var myHTMLString = ""
        let myURLString = "http://pluginstreaming.com/retrieveSongFromName.php?a=" + songTitle.text!
        print("URL String: " + myURLString)
        guard let myURL3 = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }
        
        do {
            myHTMLString = try String(contentsOf: myURL3, encoding: .ascii)
        } catch let error {
            print("Error: \(error)")
        }
        print("Song ID: " + myHTMLString)
        print("Party ID: " + String(partyID))
        let userID = User.userID
        let postString2 = "a=\(myHTMLString)&b=\(partyID)&c=1"
        let request2 = NSMutableURLRequest(url: URL(string: "http://pluginstreaming.com/insertPartySong.php")!)
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
}
