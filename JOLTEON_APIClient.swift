//
//  JOLTEON_APIClient.swift
//  Jolteon
//
//  Created by Dylan Straughan on 6/25/16.
//  Copyright © 2016 Dylan Straughan. All rights reserved.
//

import Foundation

struct JOLTEON_APIClient {
    
    var JSONDictionary:[[String:Int]]?
    
    static func get(completion:(success:Bool, object:[[String:AnyObject]]) -> ()) {
        
        let url = NSURL(string: "http://jolteon.cricket:4000/yellow")!
        let session: NSURLSession = NSURLSession.sharedSession()
        let task:NSURLSessionDataTask = session.dataTaskWithURL(url) { (data, response, error) in
            
            if let data = data {
                do {
                    if let obj = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [[String:AnyObject]] {
                        completion(success: true, object: obj)
                    } else {
                        completion(success: false, object: [])
                    }
                    
                } catch let error as NSError {
                    print("json error \(error.localizedDescription)")
                    completion(success: true, object: [])
                }
            }
        }
        
        task.resume()
    }
    
    static func post(dictionary:[String:AnyObject]?) {
        
        let url = NSURL(string: "http://jolteon.cricket:4000/yellow")!
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        if let dictionary = dictionary  {
            do {
                let jsonData = try NSJSONSerialization.dataWithJSONObject(dictionary, options: NSJSONWritingOptions.PrettyPrinted)
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(jsonData, options: [])
                
                let session: NSURLSession = NSURLSession.sharedSession()
                let task:NSURLSessionDataTask = session.dataTaskWithURL(url) { (data, response, error) in

                }
                task.resume()
                
            } catch let error as NSError {
                print(error)
            }
        }
    }
}
