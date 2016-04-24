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
    
    var city: String = ""
    var state: String = ""
    
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

            // text() is different from '.' i think because '.' means values?
            // Go through the content of the page and find the location in every single paragraph
            
            city = "Cleveland"
            state = "OH"
            
            // Header
            for link in doc.xpath("//div[@id='content']//p//strong[contains(., '\(city)')]") {
                print(link.text!)
            }
            
            // Paragraph
            for link in doc.xpath("//div[@id='content']//p[contains(., '\(city), \(state)')]") {
                print(link.text!)
            }
        }
        
    }
}
