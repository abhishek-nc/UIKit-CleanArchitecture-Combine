//
//  NewsInteractor.swift
//  MachineTest
//
//  Created by Abhishek Chandrashekar on 09/11/20.
//

import Foundation
import Combine

/*
class NewsInteractor: NewsInteractorInput {
    
    var newsClient : APIClientProtocol?
    weak var presenter: NewsInteractorOutput?
    
    //dependency injection
    init() {
        newsClient = APIClient(authorizationManager: NetworkManager.shared)
    }
    
    func getNews() {
        newsClient?.fetch(request: NewsRequest.getNews, basePath: "http://newsapi.org/", keyDecodingStrategy: .useDefaultKeys, completionHandler: { [weak self](abc: Result<Articles, NetworkError>) in
            switch abc {
            case .success(let article):
                self?.presenter?.updateNews(news: article, err: nil)
            case .failure(let err):
                self?.presenter?.updateNews(news: nil, err: err)
            }
        })
    }
 
}
 */

class ETVNewsInteractorModel: ETVNewsInteractor {
  var remoteClient: NetworkManagerProtocol
  
  init(remoteClient: NetworkManagerProtocol) {
    self.remoteClient = remoteClient
  }
  
  func fetchNews() -> AnyPublisher<[NewsItem]?, Error> {
    guard let request = ETVNewsListRequest.getAllNews.makeRequest() else {
      return Fail(error: NetworkError.other(message: "invalid")).eraseToAnyPublisher()
    }
    return remoteClient.makeRequest(request: request)
      .decode(type: Articles.self, decoder: JSONDecoder())
      .map{$0.news}
      .receive(on: RunLoop.main)
      .eraseToAnyPublisher()
  }
  
  func fetchNewsFromRemote() -> AnyPublisher<Articles, Error> {
    return AnyPublisher.init(Empty())
  }
  
  func fetchNewsFromCache() -> AnyPublisher<Articles, Error> {
    return AnyPublisher.init(Empty())
  }
  
  
}
