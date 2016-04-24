//
//  TestViewController.swift
//  Geotagging
//
//  Created by Huyanh Hoang on 2016. 4. 23..
//  Copyright © 2016년 baemax. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    let url = "http://www.archives.gov/research/guide-fed-records/groups/255.html"
    
    var myHTMLString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let myURL = NSURL(string: url) {
            
            do {
                myHTMLString = try String(contentsOfURL: myURL, encoding: NSUTF8StringEncoding)
                //print("HTML : \(myHTMLString)")
            } catch {
                print("Error : \(error)")
            }
        } else {
            print("Error: \(url) doesn't  URL")
        }        
        
        if let doc = HTML(html: myHTMLString, encoding: NSUTF8StringEncoding) {
            print(doc.title)
            
            // Search for nodes by CSS
//            for link in doc.css("a, link") {
//                print(link.text)
//                print(link["href"])
//            }
            print("---------------------------------")
            // Search for nodes by XPath

            for link in doc.xpath("//p | //strong") {
                print(link.text!)
                print("-----")
                print(link["href"])
            }
        }
        
    }
}
