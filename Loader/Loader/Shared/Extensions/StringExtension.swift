//
//  StringExtension.swift
//  Loader
//
//  Created by Sergiy Kostrykin on 4/11/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Foundation

extension String {
    
    var fromBase64: String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    var toBase64: String {
        return Data(self.utf8).base64EncodedString()
    }
}
