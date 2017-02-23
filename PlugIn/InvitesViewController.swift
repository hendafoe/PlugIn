//
//  InvitesViewController.swift
//  PlugIn
//
//  Created by Will Lazebnik on 1/31/17.
//  Copyright © 2017 Henry Dafoe. All rights reserved.
//

import UIKit

class InvitesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var invites: [Int] = []
    @IBOutlet var invitesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        invitesTable.delegate = self
        invitesTable.dataSource = self
        //invitesTable.register(TableViewCell.self, forCellReuseIdentifier: "customcell")
        
        let myURLString2 = "http://pluginstreaming.com/retrieveInvites.php?a=" + String(User.userID)
        guard let myURL2 = URL(string: myURLString2) else {
            print("Error: \(myURLString2) doesn't seem to be a valid URL")
            return
        }
        
        do {
            print("Invites:")
            var myHTMLString2 = try String(contentsOf: myURL2, encoding: .ascii)
            while(myHTMLString2.range(of: "<br>") != nil)
            {
                let range: Range<String.Index> = myHTMLString2.range(of: "<br>")!
                let index = range.lowerBound
                
                let substring: String = myHTMLString2.substring(to: index)
                print(substring)
                invites.append(Int(substring)!)
                myHTMLString2.removeSubrange(myHTMLString2.startIndex..<range.upperBound)
            }
            
        } catch let error {
            print("Error: \(error)")
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = invitesTable.dequeueReusableCell(withIdentifier: "customcell", for: indexPath as IndexPath) as! TableViewCell
        cell.tableView? = invitesTable
        let inviteNumString = String(invites[indexPath.item])
        var myHTMLString3 = ""
        let myURLString3 = "http://pluginstreaming.com/retrievePartyFromInvite.php?a=" + inviteNumString
        print("URL String: " + myURLString3)
        guard let myURL3 = URL(string: myURLString3) else {
            print("Error: \(myURLString3) doesn't seem to be a valid URL")
            return cell
        }
        
        do {
            myHTMLString3 = try String(contentsOf: myURL3, encoding: .ascii)
        } catch let error {
            print("Error: \(error)")
        }
        
        print("PartyID: " + myHTMLString3)
        let myURLString4 = "http://pluginstreaming.com/retrievePartyName.php?a=" + myHTMLString3
        guard let myURL4 = URL(string: myURLString4) else {
            print("Error: \(myURLString4) doesn't seem to be a valid URL")
            return cell
        }
        
        do {
            let myHTMLString4 = try String(contentsOf: myURL4, encoding: .ascii)
            cell.cellTitle?.text = "Invite To: " + myHTMLString4
        } catch let error {
            print("Error: \(error)")
        }
        
        cell.acceptButton?.tag = Int(inviteNumString)!
        cell.declineButton?.tag = Int(inviteNumString)!
        /*
        cell.acceptButton?.addTarget(self, action: "acceptAction:", for: .touchUpInside)
        cell.declineButton?.addTarget(self, action: "declineAction:", for: .touchUpInside)*/
        
        
        return cell
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
