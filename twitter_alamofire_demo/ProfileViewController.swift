//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Samuel Carbone on 2/18/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire
class ProfileViewController: UIViewController {

    @IBOutlet weak var userBackground: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var actualName: UILabel!
    @IBOutlet weak var tweetsCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let userData = User.current?.dictionary
        let usernameValue = User.current?.screenName as! String
        username.text = "@\(usernameValue)"
        actualName.text = User.current?.name
        followingCount.text = String(describing: userData?["friends_count"] as! Int)
        followersCount.text = String(describing: userData?["followers_count"] as! Int)
        tweetsCount.text = String(describing: userData?["statuses_count"] as! Int)
        profileImage.af_setImage(withURL: URL(string: userData!["profile_image_url"] as! String)!)
//        userBackground.af_setImage(withURL: URL(string: userData!["profile_background_image_url"] as! String)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
