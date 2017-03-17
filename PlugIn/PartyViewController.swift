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

class PartyViewController: UIViewController, AVAudioPlayerDelegate {
    var partyID = 0
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    
    var played = false
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var albumArt: UIImageView!
    @IBOutlet var volumeSlider: UISlider!
    
    @IBOutlet var navBar: UINavigationItem!
    
    func playerDidFinishPlaying(note: NSNotification) {
        print("DONE!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Set party name
        var myHTMLString2 = ""
        let myURLString2 = "http://pluginstreaming.com/retrievePartyName.php?a=" + String(partyID)
        print("Party Name URL String: " + myURLString2)
        guard let myURL2 = URL(string: myURLString2) else {
            print("Error: \(myURLString2) doesn't seem to be a valid URL")
            return
        }
        do {
            myHTMLString2 = try String(contentsOf: myURL2, encoding: .ascii)
        } catch let error {
            print("Error: \(error)")
        }
        navBar.title = String(myHTMLString2)
        
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

            let url = URL(string: "http://pluginstreaming.com/wp-content/audio/" + myHTMLString4.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + ".mp3")
            print("URL String: " + String(describing: url))
            let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
            
            NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)

            
            
            
            
            player = AVPlayer(playerItem: playerItem)
            player?.volume = 0.5
        
        
            //Set artwork
            var myHTMLString5 = ""
            let myURLString5 = "http://pluginstreaming.com/retrieveSongArtwork.php?a=" + myHTMLString3
            print("URL String: " + myURLString5)
            guard let myURL5 = URL(string: myURLString5) else {
                print("Error: \(myURLString5) doesn't seem to be a valid URL")
                return
            }
            
            do {
                myHTMLString5 = try String(contentsOf: myURL5, encoding: .ascii)
            } catch let error {
                print("Error: \(error)")
            }
            
            if let url = NSURL(string: myHTMLString5) {
                if let data = NSData(contentsOf: url as URL) {
                    albumArt.image = UIImage(data: data as Data)
                }        
            }
            
            //Set tile
            var myHTMLString6 = ""
            let myURLString6 = "http://pluginstreaming.com/retrieveSongTitle.php?a=" + myHTMLString3
            print("URL String: " + myURLString6)
            guard let myURL6 = URL(string: myURLString6) else {
                print("Error: \(myURLString6) doesn't seem to be a valid URL")
                return
            }
            
            do {
                myHTMLString6 = try String(contentsOf: myURL6, encoding: .ascii)
            } catch let error {
                print("Error: \(error)")
            }
            titleLabel.text = myHTMLString6
            
            
            
            //Set Artist
            var myHTMLString7 = ""
            let myURLString7 = "http://pluginstreaming.com/retrieveSongArtist.php?a=" + myHTMLString3
            print("URL String: " + myURLString7)
            guard let myURL7 = URL(string: myURLString7) else {
                print("Error: \(myURLString7) doesn't seem to be a valid URL")
                return
            }
            
            do {
                myHTMLString7 = try String(contentsOf: myURL7, encoding: .ascii)
            } catch let error {
                print("Error: \(error)")
            }
            artistLabel.text = myHTMLString7

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
        player = nil
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
    
    @IBAction func volumeSlide(_ sender: AnyObject) {
        player!.volume = volumeSlider.value
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
