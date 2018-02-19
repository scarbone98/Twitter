//
//  CreateTweetViewController.swift
//  twitter_alamofire_demo
//
//  Created by Samuel Carbone on 2/17/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

protocol CreateTweetViewControllerDelegate:class {
    func did(post: Tweet)
}
class CreateTweetViewController: UIViewController, UITextViewDelegate {
    var maxChars = 140
    weak var delegate: CreateTweetViewControllerDelegate?
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var charTracker: UILabel!
    var currentChars = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createTweet(_ sender: Any) {
        let textCount = textView.text.count
        if(textCount <= 140 && !textView.text.isEmpty){
            APIManager.shared.composeTweet(with: textView.text) { (tweet, error) in
                if let error = error {
                    print("Error composing Tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    self.delegate?.did(post: tweet)
                    self.dismiss(animated: true, completion: {
                        
                    })
                    print("Compose Tweet Success!")
                }
            }
        }
    }
    
    @IBAction func onCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let textCount = textView.text.count
        if(textCount <= 140){
            charTracker.textColor = UIColor.black
        }
        else{
            charTracker.textColor = UIColor.red
        }
        charTracker.text = "\(textCount)/140"
    }
    
}
