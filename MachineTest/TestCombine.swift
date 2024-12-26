//
//  TestCombine.swift
//  MachineTest
//
//  Created by Abhishek N C on 18/12/24.
//

import Foundation
import Combine

class Address {}

actor UserProfile {
  var name: String?
  var address: Address?
  
  func test() async {
    await withCheckedContinuation { continuation in
      continuation.resume()
    }
  }
  
  func testPublisher() {
    let publisher = [1,2,3].publisher.multicast(subject: PassthroughSubject())
  }
}
