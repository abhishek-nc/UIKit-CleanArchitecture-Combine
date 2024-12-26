//
//  NewsRequest.swift
//  MachineTest
//
//  Created by Abhishek Chandrashekar on 09/11/20.
//

import Foundation

enum ETVNewsListRequest : ETVRemoteRequest {
  
    case getAllNews
  //case getHeadline
    
  var basePath: String {
    return "http://newsapi.org/"
  }
    var path: String {
        return "/v2/everything"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: RequestParams {
        var reqParam : RequestParams!
        
        var queryDict = [String:String]()
        queryDict["q"] = "bitcoin"
        queryDict["apiKey"] = "55c23c9f979d46e5bade55a65afca43b"
        reqParam = RequestParams(urlParameters: queryDict, bodyParameters: nil)
        return reqParam
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    var dataType: ResponseDataType {
        return .JSON
    }
    
    
}
