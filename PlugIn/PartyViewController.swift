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

class PartyViewController: UIViewController, AVAudioPlayerDelegate, UITableViewDelegate, UITableViewDataSource {
    var partyID = 0
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var audioDurationSeconds: Float64 = 0.0
    
    var played = false
    var songPlaying = "-1"
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var albumArt: UIImageView!
    @IBOutlet var volumeSlider: UISlider!
    
    @IBOutlet var navBar: UINavigationItem!
    
    var lives: [Int] = []
    
    func playerDidFinishPlaying(note: NSNotification) {
        print("DONE!")
        var myHTMLString = ""
        let myURLString = "http://pluginstreaming.com/retrieveSongRank.php?a=" + songPlaying + "&b=" + String(partyID)
        print("URL String: " + myURLString)
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }
        
        do {
            myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
        } catch let error {
            print("Error: \(error)")
        }
        var rank = myHTMLString
        var rank2 = String(Int(rank)! + 1)
        print(rank2)
        
        var myHTMLString2 = ""
        let myURLString2 = "http://pluginstreaming.com/retrieveSongFromRank.php?a=" + rank2 + "&b=" + String(partyID)
        print("URL String: " + myURLString2)
        guard let myURL2 = URL(string: myURLString2) else {
            print("Error: \(myURLString2) doesn't seem to be a valid URL")
            return
        }
        
        do {
            myHTMLString2 = try String(contentsOf: myURL2, encoding: .ascii)
        } catch let error {
            print("Error: \(error)")
        }
        
        if(myHTMLString2 != "0 results")
        {
            updateStartpoint()
            songPlaying = myHTMLString2
            playSong(songID: myHTMLString2)
            player?.play()
            played = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        }
        catch {
           print("error")
        }
        
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
        navBar.title = User.removeOptional(input: String(myHTMLString2))
        
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
            songPlaying = myHTMLString3
            playSong(songID: myHTMLString3)
        }
    
        
        
        
        let myURLString8 = "http://pluginstreaming.com/retrieveLives.php?a=" + String(partyID)
        guard let myURL8 = URL(string: myURLString8) else {
            print("Error: \(myURLString8) doesn't seem to be a valid URL")
            return
        }
            do {
                print("Parties:")
                var myHTMLString8 = try String(contentsOf: myURL8, encoding: .ascii)
                if(myHTMLString8 == "0 results")
                {
                    updateStartpoint()
                }
                else
                {
                    while(myHTMLString8.range(of: "<br>") != nil)
                    {
                        let range: Range<String.Index> = myHTMLString8.range(of: "<br>")!
                        let index = range.lowerBound
                
                        let substring: String = myHTMLString8.substring(to: index)
                        print(substring)
                        lives.append(Int(substring)!)
                        myHTMLString8.removeSubrange(myHTMLString8.startIndex..<range.upperBound)
                    }
                }
            } catch let error {
                print("Error: \(error)")
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
    
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "customcell")
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        player = nil
        let postString2 = "a=0&b=\(partyID)&c=\(User.userID)"
        let request2 = NSMutableURLRequest(url: URL(string: "http://pluginstreaming.com/setUserLive.php")!)
        request2.httpMethod = "POST"
        request2.httpBody = postString2.data(using: String.Encoding.utf8);
        NSURLConnection.sendAsynchronousRequest(request2 as URLRequest, queue: OperationQueue.main)
        {
            (response, data, error) in
            print(response)
            if let HTTPResponse = response as? HTTPURLResponse {
                let statusCode = HTTPResponse.statusCode
                if statusCode == 200 {
                    print("Update successful")
                }
            }
        }

        
        
        if segue.identifier == "InviteSegue"
        {
            if let destinationVC = segue.destination as? AddPartyFriendViewController {
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
            simultaneous()
            played = true
            player!.play()
        }
    }
    
    @IBAction func volumeSlide(_ sender: AnyObject) {
        player!.volume = volumeSlider.value
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lives.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "livecell", for: indexPath as IndexPath)
        
        
        let myURLString3 = "http://pluginstreaming.com/retrieveUsername.php?a=" + String(lives[indexPath.item])
        guard let myURL3 = URL(string: myURLString3) else {
            print("Error: \(myURLString3) doesn't seem to be a valid URL")
            return cell
        }
        
        do {
            let myHTMLString3 = try String(contentsOf: myURL3, encoding: .ascii)
            cell.textLabel?.text = User.removeOptional(input: myHTMLString3)
        } catch let error {
            print("Error: \(error)")
        }
        return cell
    }
    
    
    func updateStartpoint()
    {
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let result = formatter.string(from: date)
        
        let postString3 = "a=\(result)&b=\(partyID)"
        let request3 = NSMutableURLRequest(url: URL(string: "http://pluginstreaming.com/setPartyStartpoint.php")!)
        request3.httpMethod = "POST"
        request3.httpBody = postString3.data(using: String.Encoding.utf8);
        NSURLConnection.sendAsynchronousRequest(request3 as URLRequest, queue: OperationQueue.main)
        {
            (response, data, error) in
            print(response)
            if let HTTPResponse = response as? HTTPURLResponse {
                let statusCode = HTTPResponse.statusCode
                if statusCode == 200 {
                    print("Update successful")
                }
            }
        }
        
        
        print("the date of today")
        print(result)
    }
    func simultaneous()
    {
        // SIMULTANEOUS (THIS IS IT)
        
        
        var myHTMLString500 = ""
        let myURLString500 = "http://pluginstreaming.com/retrieveStartpoint.php?a=" + String(partyID)
        print("URL String: " + myURLString500)
        guard let myURL500 = URL(string: myURLString500) else {
            print("Error: \(myURLString500) doesn't seem to be a valid URL")
            return
        }
        
        do {
            myHTMLString500 = try String(contentsOf: myURL500, encoding: .ascii)
        } catch let error {
            print("Error: \(error)")
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let startDate = dateFormatter.date(from: myHTMLString500)
        
        let secsIn = -Float((startDate?.timeIntervalSinceNow)!)
        print("Seconds In: " + String(secsIn))
        
        
        if (secsIn < Float(audioDurationSeconds))
        {
            print("CHANGING SONG TIME")
            player?.seek(to: CMTimeMakeWithSeconds(Float64(secsIn), 1))
        }

    }
    
    func playSong(songID: String)
    {
        var myHTMLString4 = ""
        let myURLString4 = "http://pluginstreaming.com/retrieveSongName.php?a=" + songID
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
        playerItem = AVPlayerItem(url: url!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
    
        
        
        //Set up player
        player = AVPlayer(playerItem: playerItem)
        player?.volume = 0.5
        let audioDuration = playerItem?.asset.duration
        audioDurationSeconds = CMTimeGetSeconds(audioDuration!)
        
        
        
        //Set artwork
        var myHTMLString5 = ""
        let myURLString5 = "http://pluginstreaming.com/retrieveSongArtwork.php?a=" + songID
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
        
        //Set title
        var myHTMLString6 = ""
        let myURLString6 = "http://pluginstreaming.com/retrieveSongTitle.php?a=" + songID
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
        let myURLString7 = "http://pluginstreaming.com/retrieveSongArtist.php?a=" + songID
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
        
        //Set Live
        let postString2 = "a=1&b=\(partyID)&c=\(User.userID)"
        let request2 = NSMutableURLRequest(url: URL(string: "http://pluginstreaming.com/setUserLive.php")!)
        request2.httpMethod = "POST"
        request2.httpBody = postString2.data(using: String.Encoding.utf8);
        NSURLConnection.sendAsynchronousRequest(request2 as URLRequest, queue: OperationQueue.main)
        {
            (response, data, error) in
            print(response)
            if let HTTPResponse = response as? HTTPURLResponse {
                let statusCode = HTTPResponse.statusCode
                if statusCode == 200 {
                    print("Update successful")
                }
            }
        }
        simultaneous()
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
