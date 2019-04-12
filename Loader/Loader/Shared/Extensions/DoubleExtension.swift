//
//  DoubleExtension.swift
//  Loader
//
//  Created by Sergiy Kostrykin on 4/12/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Foundation

extension Double {
    
    func writeToFile(for key: String) {
        let dictionary = [key: self]
        let documentsUrl = FileManager.default.homeDirectoryForCurrentUser
        let fileUrl = documentsUrl.appendingPathComponent(AppConfig.configPath)
        if
            let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted),
            let string = String(data: jsonData, encoding: .utf8) {
            try? string.write(to: fileUrl, atomically: true, encoding: .utf8)
        }
    }
    
    static func readFromFile(with key: String) -> Double? {
        let documentsUrl = FileManager.default.homeDirectoryForCurrentUser
        let fileUrl = documentsUrl.appendingPathComponent(AppConfig.configPath)
        if
            let string = try? String(contentsOf: fileUrl, encoding: .utf8),
            let data = string.data(using: .utf8),
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            return json[key] as? Double
        }
        return nil
    }

}
