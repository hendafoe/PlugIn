//
//  PartyViewController.swift
//  PlugIn
//
//  Created by Will Lazebnik on 1/31/17.
//  Copyright © 2017 Henry Dafoe. All rights reserved.
//

import UIKit
import AVFoundation

class PartyViewController: UIViewController {
    var partyID = 0
    var player: AVAudioPlayer?
    
    @IBOutlet var navBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.title = String(partyID)
        
        //play song
        let url = NSURL(string: "http://pluginstreaming.com/wp-content/audio/Drake.mp3")
        
        do {
            player = try AVAudioPlayer(contentsOf: url as! URL)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InviteSegue"
        {
            if let destinationVC = segue.destination as? AddSongViewController {
                print("AAAASFASDQW")
                destinationVC.partyID = partyID
            }
        }
    }

    @IBAction func addFriend(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "InviteSegue", sender: self)
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
