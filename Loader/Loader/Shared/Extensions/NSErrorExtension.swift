//
//  NSErrorExtension.swift
//  Loader
//
//  Created by Sergiy Kostrykin on 4/11/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Foundation

extension NSError {
    class func standard(message: String?) -> NSError {
        return NSError(domain: "self", code: 0, userInfo: [NSLocalizedDescriptionKey: message ?? ""])
    }
}
