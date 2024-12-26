import Foundation
import Combine

class NetworkManager: NetworkManagerProtocol {
  
  static let shared = NetworkManager()
  
  func makeRequest(request: URLRequest) -> AnyPublisher<Data, Error> {
     return URLSession.shared.dataTaskPublisher(for: request)
      .mapError({ error -> Error in
        NetworkError.other(message: error.localizedDescription)
      })
      .map { $0.data }
      .eraseToAnyPublisher()
  }
  
  func performDownloadTask() {
    
  }
  
  func performBackgroundTask() {
    
  }
  
  func performUploadTask() {
    
  }
  
}
fileprivate func logOneEvent(data: Data, response: URLResponse) {
    print("Got \(data.count) bytes")
    print("Response: \(response)")
}

extension Publisher where Output == URLSession.DataTaskPublisher.Output
{
    func logEvents() -> Publishers.HandleEvents<Self> {
        return self.handleEvents(receiveOutput: logOneEvent)
    }
}
/*
 generic : stck<T:p> ;
 opaque : some UIView
 type eraser: AnyPublisher<>
 
 swap<T>(a,b) -> T
 swap<T:equitable >(a,b) -> some Equitable  //
 swap(a,b) -> any
 */
