//
//  View.swift
//  AccessWebAPI
//
//  Created by 阿部 潤平 on 2014/06/30.
//  Copyright (c) 2014年 Self. All rights reserved.
//

import Foundation
import UIKit

class View: UIView, NSXMLParserDelegate {
    var entries : NSMutableArray!
    
    var rssUrl : NSURL!
    
    // APIへアクセスしXMLを読み込む
    func loadAPI(){
        NSLog("rssUrl")
        
        // URLRequest
        let request : NSURLRequest = NSURLRequest(URL:self.rssUrl)
        
        // URLRequest成功時に実行される関数
        func completionBlock(data: NSData!, response: NSURLResponse!, error: NSError!) -> Void {
            var parser : NSXMLParser = NSXMLParser(data: data)
            parser.delegate = self;
            parser.parse()
        }
        var task : NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler:completionBlock)
        task.resume()
    }

    init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.blueColor()
        
        entries = NSMutableArray()
        NSLog("init1")

        let url : NSURL = NSURL(string: "http://qiita.com/tags/Swift/feed.atom")
        self.rssUrl = url
        loadAPI()
        NSLog("init2")
    }
    
    // NSXMLParserDelegate
    var parseKey : String!
    var tmpEntry : Entry!
    
    let entryKey = "entry"
    let titleKey = "title"
    let urlKey   = "url"
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: NSDictionary!)
    {
        NSLog("didStartElement")
        parseKey = nil
        if elementName == entryKey {
            tmpEntry = Entry()
            entries.addObject(tmpEntry)
        } else {
            parseKey = elementName
        }
    }
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
    {
        NSLog("didEndElement")
        parseKey = nil;
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!)
    {
        NSLog("foundCharacters")
        if parseKey? == titleKey {
            if tmpEntry {
                var tmpString : String? = tmpEntry?.title;
                tmpEntry.title = tmpString? ? tmpString! + string : string
            }
        } else if parseKey? == urlKey {
            tmpEntry.url = string
        }
    }
    func parserDidEndDocument(parser: NSXMLParser!)
    {
        let entry : Entry! = entries.objectAtIndex(0) as Entry
        NSLog(entry.title)
    }
}