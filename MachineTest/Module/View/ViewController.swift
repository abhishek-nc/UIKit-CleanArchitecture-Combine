
import UIKit
import Combine

class ViewController: UIViewController {
  
  //@observableObject / binding/ state
  var presenter: ETVNewsPresenter?
  
  @IBOutlet weak var newsCollectionView: UICollectionView!
  private var bag = Set<AnyCancellable>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    setup()
  }
  
  func setup() {
    presenter?.fetchNews() // presenter.viewEventSubject.send(.fetchNew)
    presenter?.newsPublisher
      .sink(receiveValue: { news in
        //reload
        print(news.first?.newsTitle ?? "empty")
        self.newsCollectionView.reloadData()
      })
      .store(in: &bag)
  }
}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    presenter?.news.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let newsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as? NewsCollectionViewCell
    
    newsCell?.updateNewsCell(news: presenter?.news[indexPath.item])
    return newsCell ?? UICollectionViewCell.init()
  }
}
