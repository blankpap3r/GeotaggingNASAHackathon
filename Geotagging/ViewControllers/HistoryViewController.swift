//
//  HistoryViewController.swift
//  Geotagging
//
//  Created by Huyanh Hoang on 2016. 4. 24..
//  Copyright © 2016년 baemax. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    typealias dropPin = () -> Void
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var informationText: UITextView!
    
    let url = "http://www.archives.gov/research/guide-fed-records/groups/255.html"
    
    var myHTMLString: String = ""
    
    var city: String = ""
    var state: String = ""
    
    var historyArray = [String]()
    
    @IBOutlet weak var titleText: UILabel!

    var titleViewText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        informationText.selectable = false
//        tableView.dataSource = self
//        tableView.delegate = self
        
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
            titleText.text = doc.title!
            
            // text() is different from '.' i think because '.' means values?
            // Go through the content of the page and find the location in every single paragraph
            
            city = "Cleveland"
            state = "OH"
            
            // Header
            for link in doc.xpath("//div[@id='content']//p//strong[contains(., '\(city)')]") {
                //print(link.text!)
                //titleText.text = link.text!
            }
            
            // Paragraph
            for link in doc.xpath("//div[@id='content']//p[contains(., '\(city), \(state)')]") {
//                historyArray.append(link.text!)
                let modifiedString = link.text!.replace("\n", withString: " ")
                
                informationText.text = modifiedString
            }
        }
        
        
    }
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let object = historyArray[indexPath.row]
        
        cell.textLabel!.text = object
        
        return cell
    }

}