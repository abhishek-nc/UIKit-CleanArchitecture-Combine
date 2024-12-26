//
//  NewsPresenter.swift
//  MachineTest
//
//  Created by Abhishek Chandrashekar on 09/11/20.
//

import Foundation
import Combine

/* OLD VIPER
class NewsPresenter: NewsPresenterInput {
  
  weak var newView : NewsPresenterOutput?
  var interactor: NewsInteractorInput?
  var article: Articles?
  
  func fetchNews() {
    interactor?.getNews()
  }
  
}

extension NewsPresenter: NewsInteractorOutput {
  func updateNews(news:Articles?,err:NetworkError?) {
    if let _news = news {
      article = _news
      newView?.showNews(new: _news)
      return
    }
    newView?.showError(err: err)
  }
  
}
*/

enum ArticleSearchViewEvent {
    case viewDidLoad
    case refreshControlValueChanged
    case didSelect(article: NewsItem)
}

class ETVNewsPresenterModel : ETVNewsPresenter {
  //Option-1, conventional delegates to refresh view page
  
  @Published var news: [NewsItem] = []
  @Published var errorMessage: String?
  var interactor: ETVNewsInteractor
  private var bag = Set<AnyCancellable>()

  //Option-2
  var newsPublisher: Published<[NewsItem]>.Publisher { $news }
  
  let viewEventSubject = PassthroughSubject<ArticleSearchViewEvent, Never>()

  //Option-3, instead of protocol type in view, use proper class type itself, so we can access @published
  
  init(interactor: ETVNewsInteractor) {
    self.interactor = interactor
    self.news = []
    self.errorMessage = nil
    
    // view events, click, refresh, navigate etc..
    viewEventSubject
        .sink { event in
            switch event {
            case .viewDidLoad, .refreshControlValueChanged: break
                //searchKeywordSubject.send("Swift")
                
            case .didSelect(let article): break
                //router.navigationSubject.send(.articleDetail(article))
            }
        }.store(in: &bag)
  }
  
  //if required we can append/transform models here in case of  pagination
  func fetchNews() {
    return interactor.fetchNews()
      .map{ $0 ?? []}
      .replaceError(with: [])
      .receive(on: RunLoop.main)
      .assign(to: \.news, on: self)
      .store(in: &bag)
  }  
}



/* Clean + Combine + UIKit reference
 https://medium.com/@ignacio.molina.portoles/combine-applied-to-uikitviper-in-swift-cd4ee7e3b592
 https://betterprogramming.pub/uikit-mvvm-combine-912c80c02262
 https://github.com/hicka04/viper-combine-sample/blob/main/ViperCombineSample/Modules/ArticleSearch/Presenter/ArticleSearchPresenter.swift
 https://swiftsenpai.com/swift/define-protocol-with-published-property-wrapper/
 */
