//
//  JOLTEON_APIClient.swift
//  Jolteon
//
//  Created by Dylan Straughan on 6/25/16.
//  Copyright © 2016 Dylan Straughan. All rights reserved.
//

import Foundation

struct APIClient {
    
    var JSONDictionary:[[String:Int]]?
    
    static func get(completion:(success:Bool, object:[String:String]) -> ()) {
        
        let url = NSURL(string: "http://jolteon.cricket/ledstrip")!
        let session: NSURLSession = NSURLSession.sharedSession()
        let task:NSURLSessionDataTask = session.dataTaskWithURL(url) { (data, response, error) in
            
            if let data = data {
                do {
                    if let obj = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:String] {
                        completion(success: true, object: obj)
                    } else {
                        completion(success: false, object: [:])
                    }
                    
                } catch let error as NSError {
                    print("json error \(error.localizedDescription)")
                    completion(success: true, object: [:])
                }
            }
        }
        
        task.resume()
    }
    
    static func post(dictionary:[String:AnyObject]?) {
        
        let session: NSURLSession = NSURLSession.sharedSession()

        let url = NSURL(string: "http://jolteon.cricket/ledstrip")!
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let dictionary = dictionary  {
            do {
                let jsonData = try NSJSONSerialization.dataWithJSONObject(dictionary, options: [])
                request.HTTPBody = jsonData
                let task:NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
                    
                    if let data = data {
                        do {
                        let obj = try NSJSONSerialization.JSONObjectWithData(data, options: [])
                        print(obj)
                        if let httpResponse = response as? NSHTTPURLResponse {
                            print("status code: \(httpResponse.statusCode)")
                        }
                            
                        } catch {
                        
                        }
                    }
                    if error != nil {
                        print(error?.localizedDescription)
                    }
                })
                
                task.resume()
                
            } catch let error as NSError {
                print(error)
            }
        }
    }
}
