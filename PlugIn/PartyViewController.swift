//
//  PartyViewController.swift
//  PlugIn
//
//  Created by Will Lazebnik on 1/31/17.
//  Copyright © 2017 Henry Dafoe. All rights reserved.
//

import UIKit
import AVFoundation
//import ID3Edit

class PartyViewController: UIViewController {
    var partyID = 0
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    
    var played = false
    
    @IBOutlet var navBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.title = String(partyID)
        
        //Set up song
        var myHTMLString3 = ""
        let myURLString3 = "http://pluginstreaming.com/retrieveFirstSong.php?a=" + String(partyID)
        print("URL String: " + myURLString3)
        guard let myURL3 = URL(string: myURLString3) else {
            print("Error: \(myURLString3) doesn't seem to be a valid URL")
            return
        }
        
        do {
            myHTMLString3 = try String(contentsOf: myURL3, encoding: .ascii)
        } catch let error {
            print("Error: \(error)")
        }
        if(myHTMLString3 != "0 results")
        {
            var myHTMLString4 = ""
            let myURLString4 = "http://pluginstreaming.com/retrieveSongName.php?a=" + myHTMLString3
            print("URL String: " + myURLString4)
            guard let myURL4 = URL(string: myURLString4) else {
                print("Error: \(myURLString4) doesn't seem to be a valid URL")
                return
            }
            
            do {
                myHTMLString4 = try String(contentsOf: myURL4, encoding: .ascii)
            } catch let error {
                print("Error: \(error)")
            }

            let url = URL(string: "http://pluginstreaming.com/wp-content/audio/" + myHTMLString4 + ".mp3")
            print("URL String: " + String(describing: url))
            let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
            player = AVPlayer(playerItem: playerItem)
        }
        /*
        
        // Open the file
        let mp3File = try MP3File(path: "/Users/Example/Music/example.mp3")
        // Use MP3File(data: data) data being an NSData object
        // to load an MP3 file from memory
        // NOTE: If you use the MP3File(data: NSData?) initializer make
        //       sure to set the path before calling writeTag() or an
        //       exception will be thrown
        
        // Get song information
        print("Title:\t\(mp3File.getTitle())")
        print("Artist:\t\(mp3File.getArtist())")
        print("Album:\t\(mp3File.getAlbum())")
        print("Lyrics:\n\(mp3File.getLyrics())")
        
        let artwork = mp3File.getArtwork()
        
        // Write song information
        mp3File.setTitle("The new song title")
        mp3File.setArtist("The new artist")
        mp3File.setAlbum("The new album")
        mp3File.setLyrics("Yeah Yeah new lyrics")
        
        if let newArt = NSImage(contentsOfFile: "/Users/Example/Pictures/example.png")
        {
            mp3File.setArtwork(newArt, isPNG: true)
        }
        else
        {
            print("The artwork referenced does not exist.")
        }
        
        // Save the information to the mp3 file
        mp3File.writeTag() // or mp3.getMP3Data() returns the NSData
        // of the mp3 file
        
        catch ID3EditErrors.FileDoesNotExist
        {
        print("The file does not exist.")
        }
        catch ID3EditErrors.NotAnMP3
        {
        print("The file you attempted to open was not an mp3 file.")
        }
        catch {}*/ 
    
        
        
        
        
        
        
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
    
    @IBAction func playPause(_ sender: AnyObject) {
        if played
        {
            player!.pause()
            played = false
        }
        else
        {
            player!.play()
            played = true
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
