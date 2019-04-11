//
//  Connection.swift
//  Loader
//
//  Created by Sergiy Kostrykin on 4/11/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Foundation

class Connection {

    typealias Completion = (Any?, URLResponse?, Error?) -> Void
    
    enum Method: String {
        case GET
        case POST
        case PUT
    }

    class func startTask(for urlString: String, parameters: [String: String]? = nil, body: Data? = nil, method: Method? = nil, completion: Completion?) {
        var url: URL?
        do {
            url = try Connection.url(for: urlString, parameters: parameters)
        } catch {
            completion?(nil, nil, error)
            return
        }
        
        guard let requestUrl = url else {
            let error = NSError.standard(message: "URL not found")
            completion?(nil, nil, error)
            return
        }
        
        var request = URLRequest(url: requestUrl)
        
        request.httpMethod = method != nil ? method!.rawValue : body == nil ? "GET" : "POST"
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                if (error as NSError).code != NSURLErrorCancelled {
                    completion?(nil, response, error)
                }
                return
            }
            guard
                let data = data,
                let string = String(data: data, encoding: .utf8),
                let decodedString = string.fromBase64,
                let json = try? JSONSerialization.jsonObject(with: Data(decodedString.utf8), options: [])
                else {
                    let error = NSError.standard(message: "Error Loading Data")
                    completion?(nil, response, error)
                    return
            }
            completion?(json, response, error)
        }
        
        task.resume()
    }
    
    static func url(for urlString: String, parameters: [String: String]? = nil) throws -> URL {
        var str = urlString
        if let parameters = parameters {
            for parameter in parameters {
                let value = parameter.value
                guard let validValue = value.addingPercentEncoding(withAllowedCharacters: []) else {
                    let error = NSError.standard(message: "Error Loading Data")
                    throw error
                }
                str += str == urlString ? "?" : "&"
                str += parameter.key + "=" + validValue
            }
        }
        
        guard let url = URL(string: str) else {
            let error = NSError.standard(message: "URL not found")
            throw error
        }
        
        return url
    }
    
    
    class func request(name: String, date: String, completion: ((Response?, Error?) -> Void)?) {
        let path = AppConfig.baseUrl + "/mc/in"
        let params = ["name": name]
        let dict = ["date": date]
        let body = try? JSONSerialization.data(withJSONObject: dict, options: [])
        Connection.startTask(for: path, parameters: params, body: body) { json, _, error in
            if let error = error {
                completion?(nil, error)
                return
            }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: json ?? [:], options: .prettyPrinted)
                let request = try JSONDecoder().decode(Response?.self, from: jsonData)
                DispatchQueue.main.async {
                    completion?(request, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion?(nil, error)
                }
            }
        }
    }
    

}
