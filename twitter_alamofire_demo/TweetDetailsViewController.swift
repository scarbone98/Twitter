//
//  TweetDetailsViewController.swift
//  twitter_alamofire_demo
//
//  Created by Samuel Carbone on 2/18/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    @IBOutlet weak var retweetImage: UIImageView!
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var created_at: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    var tweet: Tweet!
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextLabel.text = tweet.text
        retweetCount.text = "\(tweet.retweetCount)"
        favoriteCount.text = "\(tweet.favoriteCount!)"
        created_at.text = "\(tweet.createdAtString)"
        screenName.text = "@\(tweet.screenName)"
        userName.text = "\(tweet.name)"
        profileImage.layer.cornerRadius = 8.0
        profileImage.clipsToBounds = true
        profileImage.af_setImage(withURL: URL(string: tweet.imageUrl)!)
        if let favorited = tweet.favorited{
            if favorited{
                favoriteImage.image = UIImage(imageLiteralResourceName: "favor-icon-red")
            }
            else{
                favoriteImage.image = UIImage(imageLiteralResourceName: "favor-icon")
            }
        } else{
            favoriteImage.image = UIImage(imageLiteralResourceName: "favor-icon")
        }
        if tweet.retweeted {
            retweetImage.image = UIImage(imageLiteralResourceName: "retweet-icon-green")
        }
        else{
            retweetImage.image = UIImage(imageLiteralResourceName: "retweet-icon")
        }
        let favoriteRecognizer = UITapGestureRecognizer(target: self, action: #selector(favoriteTapped(tapGestureRecognizer:)))
        let retweetTapped = UITapGestureRecognizer(target: self, action: #selector(retweetTapped(tapGestureRecognizer:)))
        retweetImage.addGestureRecognizer(retweetTapped)
        favoriteImage.addGestureRecognizer(favoriteRecognizer)
        // Do any additional setup after loading the view.
    }
    @objc func favoriteTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        favoriteImage.isUserInteractionEnabled = false
        if tweet.favorited! {
            APIManager.shared.favoriteTweet(self.tweet, completion: { (tweet, error) in
                if tweet != nil {
                    self.favoriteImage.image = UIImage(imageLiteralResourceName: "favor-icon-red")
                    self.favoriteCount.text = "\(self.tweet.favoriteCount! + 1)"
                }
                else if let error = error {
                    print(error.localizedDescription)
                }
                self.favoriteImage.isUserInteractionEnabled = true
            })
        }
        else{
            APIManager.shared.unFavoriteTweet(self.tweet, completion: { (tweet, error) in
                if tweet != nil {
                    self.favoriteImage.image = UIImage(imageLiteralResourceName: "favor-icon")
                    self.favoriteCount.text = "\(self.tweet.favoriteCount! - 1)"
                }
                else if let error = error{
                    print(error.localizedDescription)
                }
                self.favoriteImage.isUserInteractionEnabled = true
            })
        }
    }
    @objc func retweetTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        retweetImage.isUserInteractionEnabled = false
        if !tweet.retweeted {
            APIManager.shared.retweet(self.tweet, completion: {(tweet, error) in
                if tweet != nil {
                    self.retweetImage.image = UIImage(imageLiteralResourceName: "retweet-icon-green")
                    self.retweetCount.text = "\(self.tweet.retweetCount + 1)"
                }
                else if let error = error{
                    print(error.localizedDescription)
                }
                self.retweetImage.isUserInteractionEnabled = true
            })
        }
        else{
            APIManager.shared.unRetweet(self.tweet, completion: {(tweet, error) in
                if tweet != nil {
                    self.retweetImage.image = UIImage(imageLiteralResourceName: "retweet-icon")
                    self.retweetCount.text = "\(self.tweet.retweetCount - 1)"
                }
                else if let error = error{
                    print(error.localizedDescription)
                }
                self.retweetImage.isUserInteractionEnabled = true
            })
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
