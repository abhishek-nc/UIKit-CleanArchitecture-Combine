//
//  NewsProtocol.swift
//  MachineTest
//
//  Created by Abhishek Chandrashekar on 09/11/20.
//

import Foundation
import Combine


protocol NewsPresenterInput: AnyObject  {
    //presenter
    
    var article: Articles? { get set}
    func fetchNews()
}

protocol NewsPresenterOutput: AnyObject {
    
    func showNews(new:Articles)
    func showError(err:NetworkError?)
}


protocol NewsInteractorInput: AnyObject  {
    
    func getNews()
}

protocol NewsInteractorOutput: AnyObject  {
    
    func updateNews(news:Articles?,err:NetworkError?)
    
}


/////////////////////////// Using Combine

//Presenter and Interactor can be combined to form ViewModel in swiftUI and combine

protocol ETVNewsPresenter {
  var news: [NewsItem] {get set}
  func fetchNews() 
  
  var newsPublisher: Published<[NewsItem]>.Publisher { get }

}

protocol ETVNewsInteractor {
  var remoteClient : NetworkManagerProtocol { get set }  //APIProvider protocol
  
  func fetchNews() -> AnyPublisher<[NewsItem]?,Error>
  func fetchNewsFromRemote() -> AnyPublisher<Articles,Error>
  func fetchNewsFromCache() -> AnyPublisher<Articles,Error>
}

protocol ETVRouter {
  func deeplink()
  func showDetailPage()
}

/*
 SOLID
 
 Single responsibsility: 
coredata manager is simply resposible for fetching results from core data only, should not consider network requests
 
 Open for extension and closed for modification:
 Router, tomorrow anyone can confirm to Router prototocol and register themselves here, but we cannot simply remove router protocol anywhere in system, so closed
 
 Liskov substuition:
 We can replace generic router with more precise DeeplinkRouter #Subclass and code will still work fine
 
 Interface segregation:
 Interactor protocol can be further divided into many small protocols to segregate interfaces seperately for storage manager, request manager, cache manager etc..
 
 Dependency injection:
 A Network manager can be created by confirming to network protocol and injected in init(), completly switching engines
 
 */
