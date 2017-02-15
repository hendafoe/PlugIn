//
//  InviteTableViewCell.swift
//  PlugIn
//
//  Created by Will Lazebnik on 2/7/17.
//  Copyright © 2017 Henry Dafoe. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet var acceptButton: UIButton!
    @IBOutlet var declineButton: UIButton!
    @IBOutlet var cellTitle: UILabel!    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func acceptAction(sender: UIButton) {
        //print(sender.tag as? String)
        print("lol")
        
        
    }
    @IBAction func declineAction(sender: UIButton) {
        
        //print(sender.tag as? String)
        print("lol2")
        
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
