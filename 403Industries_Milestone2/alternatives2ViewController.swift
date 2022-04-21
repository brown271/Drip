//
//  alternatives2ViewController.swift
//  403Industries_Milestone2
//
//  Created by Brad on 2022-04-21.
//

import SwiftUI
import WebKit
class alternativesViewController2: UIViewController{

    @IBOutlet weak var lemonWaterBUtton: UIButton!
    
    //1. Declare the web view
    var webView: WKWebView! = nil
    
    override func loadView() {
        
        //2. Make the web view and load it
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        //3. Set the view of ViewController to the view of the web view
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //1. Create URL to apple.com
        let myURL = URL(string: "https://www.healthline.com/nutrition/are-smoothies-good-for-you#basics")
        
        //2. Create request to go to this URL
        let myRequest = URLRequest(url: myURL!)
        
        //3. We will load the web view to go to this URL
        webView.load(myRequest)
    }

}
