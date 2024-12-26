import Foundation

protocol ETVRemoteRequest {
    var basePath: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: RequestParams { get }
    var headers: [String: String]? { get }
    var dataType: ResponseDataType { get }
    func absolutePath(from basePath: String) -> String
    func makeRequest() -> URLRequest?
}


extension ETVRemoteRequest {
    func absolutePath(from basePath: String) -> String {
        return basePath + path
    }
}


extension ETVRemoteRequest {
  func makeRequest() -> URLRequest? {
    let endpoint = absolutePath(from: basePath)
    guard var urlComponents = URLComponents(string: endpoint) else {
      return nil
    }

    urlComponents.queryItems = parameters.urlParameters?.compactMap({ param -> URLQueryItem in
        return URLQueryItem(name: param.key, value: param.value)
    })

    guard let url = urlComponents.url else {
        return nil
    }

    var urlRequest = URLRequest(url: url,
                                cachePolicy: .reloadRevalidatingCacheData,
                                timeoutInterval: 30)
    urlRequest.httpMethod = method.rawValue
    
    headers?.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
    
    return urlRequest
  }
}

