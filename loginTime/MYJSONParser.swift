//
//  JSONParser.swift
//  loginTime
//
//  Created by Xavier Heroult on 06/04/2016.
//  Copyright © 2016 Xavier Heroult. All rights reserved.
//

import Foundation


class MYJSONParser {
    
    func parseDictionnary(data: NSData?) -> [String: AnyObject]? {
        do {
                if let data = data, json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String: AnyObject] {
                    return json
                }
            }catch{
                print("Unable to parse JSON: \(error)")
            }
        return nil
    }
}