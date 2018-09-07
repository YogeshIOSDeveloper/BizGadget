//
//  PrivacyPolicyViewController.swift
//  BizGadget
//
//  Created by Yogesh Date on 18/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {

    @IBOutlet weak var myWebView: UIWebView!
    @IBOutlet weak var myActivity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRequest()
    }
    
    func loadRequest() {
        let url = URL(string: "https://www.google.com")
        let requestObj = URLRequest(url: url! as URL)
        myWebView.loadRequest(requestObj)
        self.myWebView.delegate = self
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

extension PrivacyPolicyViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.myActivity.isHidden = false
        self.myActivity.startAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.myActivity.isHidden = true
        self.myActivity.startAnimating()
    }
}

