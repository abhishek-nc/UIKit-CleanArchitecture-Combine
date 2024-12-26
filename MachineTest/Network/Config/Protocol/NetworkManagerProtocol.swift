import Foundation
import Combine

protocol NetworkManagerProtocol {
  
  //define
  /*
   */
  
  func makeRequest(request: URLRequest) -> AnyPublisher<Data, Error>
  
  //define funcationalties
  func performDownloadTask()
  func performBackgroundTask()
  func performUploadTask()
  
  /*
   cancelTasks()
   */
}
