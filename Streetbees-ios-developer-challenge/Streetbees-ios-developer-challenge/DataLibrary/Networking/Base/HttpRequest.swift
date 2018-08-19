//
//  HttpRequest.swift
//  Streetbees-ios-developer-challenge
//
//  Created by Yasir Basharat on 17/08/2018.
//  Copyright © 2018 Yasir Basharat. All rights reserved.
//

import Foundation
public protocol BaseClientRequest {
}
extension BaseClientRequest {
}

enum HttpWebMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum HttpRequestContentType: String {
    //If needed more content type can be define here
    case json               = "application/json"
    case xml                = "text/xml; charset=utf-8"
    case formurlencoded     = "application/x-www-form-urlencoded"
    case multipartFormData  = "formData"
}

enum HttpRequestQueryType {
    case json, path //Json is used for post body.
}

protocol HttpRequest: class {
    associatedtype ResponseObject
    var baseUrl: URL { get }
    var endpoint: HttpEndpoint { get }
    var contentType: HttpRequestContentType { get }
    var timeout: TimeInterval { get }
    var bodyData: Data? { get }
    var cachePolicy: NSURLRequest.CachePolicy { get }
    var method: HttpWebMethod { get }
    var query: HttpRequestQueryType { get }
    var parameters: [String: Any]? { get }
    var session: URLSession { get }
    func sendRequest<T: Decodable>(decode: @escaping (Decodable) -> T?,
                                   completion: @escaping (HttpRequestResult<T, HttpRequestError>) -> Void)
}

extension HttpRequest {
    typealias RequestCompletionHandler = (Decodable?, HttpRequestError?) -> Void
    var contentType: HttpRequestContentType {
        return .json
    }
    var method: HttpWebMethod {
        return .get
    }
    var baseUrl: URL {
        return URL(string: "https://gateway.marvel.com:443/v1/public/")!
    }
    var timeout: TimeInterval {
        return 60
    }
    var bodyData: Data? {
        return nil  //Data for Post Request
    }
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
    var query: HttpRequestQueryType {
        return .path //Default is get request
    }
    //If request is get and with parameter names we can use this
    var parameters: [String: Any]? {
        return nil
    }
    var session: URLSession {
        return URLSession(configuration: URLSessionConfiguration.ephemeral)
    }
    /// SendRequest
    ///
    /// - Parameters:
    ///   - decode: T type
    ///   - completion: (HttpRequestResult<T, HttpRequestError>)
    func sendRequest<T: Decodable>(decode: @escaping (Decodable) -> T?,
                                   completion: @escaping (HttpRequestResult<T, HttpRequestError>) -> Void) {
        var url = baseUrl
        if !endpoint.path.isEmpty {
            let escapedString = endpoint.path.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            url = URL(string: "\(url.absoluteString)\(escapedString ?? "")")!
        }
        let request = prepareRequest(for: url)
        let task = parseResponse(with: request, decodingType: T.self) { (json, error) in
            guard let json = json else {
                if let error = error {
                    return completion(.failure(error))
                } else {
                    return completion(.failure(.message(message: NSLocalizedString("Invalid Data", comment: ""))))
                }
            }
            if let value = decode(json) {
                completion(.success(value))
            } else {
                completion(.failure(.message(message: "")))
            }
        }
        task.resume()
    }
    /// ParseResponse
    ///
    /// - Parameters:
    ///   - request: URLRequest
    ///   - decodingType: T type
    ///   - completion: CompletionHandler RequestCompletionHandler
    /// - Returns: URLSessionDataTask
    private func parseResponse<T: Decodable>(with request: URLRequest, decodingType: T.Type,
                                             completionHandler completion: @escaping RequestCompletionHandler)
        -> URLSessionDataTask {
            let task = session.dataTask(with: request) { data, response, error in
                self.logResponseFromServer(request: request, response: response, data: data)
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(nil, .exception(error: error))
                    return
                }
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        do {
                            let genericModel = try JSONDecoder().decode(decodingType, from: data)
                            completion(genericModel, nil)
                        } catch let jsonError {
                            completion(nil, .exception(error: jsonError))
                        }
                    }
                } else if let data = data {
                    do {
                        let error = try JSONDecoder().decode(ErrorStatus.self, from: data)
                        completion(nil, .responseError(errorStatus: error))
                    } catch {
                        completion(nil, .exception(error: error))
                    }
                }
            }
            return task
    }
    /// PrepareRequest
    ///
    /// - Parameter url: url
    /// - Returns: URL Request
    private func prepareRequest (for url: URL) -> URLRequest {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.query = "apikey=\(APIConstant.apiKey)"
        var request: URLRequest? = nil
        switch query {
        case .json:
            request = URLRequest(url: components.url!, cachePolicy: cachePolicy, timeoutInterval: timeout)
            if let body = bodyData {
                request!.httpBody = body
            }
        case .path:
            var query = ""
            parameters?.forEach { key, value in
                query += "&\(key)=\(value)"
            }
            if !query.isEmpty {
                components.query?.append(query)
            }
            request = URLRequest(url: components.url!, cachePolicy: cachePolicy, timeoutInterval: timeout)
        }
        request!.httpMethod = method.rawValue
        return request!
    }
    //Handy private method to print request and response
    private func logResponseFromServer(request: URLRequest?, response: URLResponse?, data: Data?) {
        if let httpReuqest = request {
            SharedLogger.logInfo("\(String(describing: self)) request : \(httpReuqest)\n")
            if let allHTTPHeaderFields = httpReuqest.allHTTPHeaderFields {
                SharedLogger.logInfo("""
                    \(String(describing: self))
                    request headers : \(SharedUtils.extractStringValue(allHTTPHeaderFields.description))\n
                    """)
            }
        }
        if let postBody = request?.httpBody,
            let strRequestBody = String(data: postBody, encoding: String.Encoding.utf8) {
            SharedLogger.logInfo("\(String(describing: self)) request body: \(strRequestBody)\n")
        }
        if let httpResponse = response {
            SharedLogger.logInfo("\(String(describing: self)) response headers : \(httpResponse)\n")
        }
        if let responseData = data, let strResponse = String(data: responseData, encoding: String.Encoding.utf8) {
            SharedLogger.logInfo("\(String(describing: self)) response : \(strResponse)\n")
        }
    }
}
