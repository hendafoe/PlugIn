//
//  HomeScreenViewController.swift
//  PlugIn
//
//  Created by Will Lazebnik on 1/19/17.
//  Copyright © 2017 Henry Dafoe. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var greetingLabel: UILabel!
    @IBOutlet var partyTable: UITableView!
    var selectParty = 0
    var parties: [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Show username
        let myURLString = "http://pluginstreaming.com/retrieveUsername.php?a=" + String(User.userID)
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }
        
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            print(myHTMLString)
            greetingLabel?.text = "Hello, " + myHTMLString
        } catch let error {
            print("Error: \(error)")
        }
    
        

        
        //Show parties
        let myURLString2 = "http://pluginstreaming.com/retrieveUserParty.php?a=" + String(User.userID)
        guard let myURL2 = URL(string: myURLString2) else {
            print("Error: \(myURLString2) doesn't seem to be a valid URL")
            return
        }
        
        do {
            print("Parties:")
            var myHTMLString2 = try String(contentsOf: myURL2, encoding: .ascii)
            while(myHTMLString2.range(of: "<br>") != nil)
            {
                let range: Range<String.Index> = myHTMLString2.range(of: "<br>")!
                let index = range.lowerBound
                
                let substring: String = myHTMLString2.substring(to: index)
                print(substring)
                parties.append(Int(substring)!)
                myHTMLString2.removeSubrange(myHTMLString2.startIndex..<range.upperBound)
            }
            
        } catch let error {
            print("Error: \(error)")
        }
        
        partyTable.delegate = self
        partyTable.dataSource = self
        partyTable.register(UITableViewCell.self, forCellReuseIdentifier: "customcell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parties.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = partyTable.dequeueReusableCell(withIdentifier: "customcell", for: indexPath as IndexPath)


        let myURLString3 = "http://pluginstreaming.com/retrievePartyName.php?a=" + String(parties[indexPath.item])
        guard let myURL3 = URL(string: myURLString3) else {
            print("Error: \(myURLString3) doesn't seem to be a valid URL")
            return cell
        }
        
        do {
            let myHTMLString3 = try String(contentsOf: myURL3, encoding: .ascii)
            cell.textLabel?.text = myHTMLString3
        } catch let error {
            print("Error: \(error)")
        }

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectParty = parties[indexPath.item]
        self.performSegue(withIdentifier: "PartySegue", sender: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PartySegue"
        {
            if let destinationVC = segue.destination as? PartyViewController {
                destinationVC.partyID = selectParty
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
