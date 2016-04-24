//
//  Utilities.swift
//  Geotagging
//
//  Created by Huyanh Hoang on 2016. 4. 24..
//  Copyright © 2016년 baemax. All rights reserved.
//

import Foundation

extension String
{
    func replace(target: String, withString: String) -> String
    {
        return self.stringByReplacingOccurrencesOfString(target, withString: withString, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
}