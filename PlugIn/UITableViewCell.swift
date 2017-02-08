//
//  InviteTableViewCell.swift
//  PlugIn
//
//  Created by Will Lazebnik on 2/7/17.
//  Copyright © 2017 Henry Dafoe. All rights reserved.
//

import UIKit

class UITableViewCell: UITableViewCell {
    @IBOutlet var acceptButton: UIButton!
    @IBOutlet var declineButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
