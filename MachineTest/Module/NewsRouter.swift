//
//  NewsRouter.swift
//  MachineTest
//
//  Created by Abhishek Chandrashekar on 09/11/20.
//

import Foundation
import UIKit

class NewsRouter {
    
    
    static func showNewsList() ->  UINavigationController {

        let list =  UIStoryboard(name:"Main",bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as! ViewController

        /* Initiating instance of ui-navigation-controller with view-controller */
        let navigationController = UINavigationController()
        navigationController.viewControllers = [list]
          let interactor =  ETVNewsInteractorModel(remoteClient: NetworkManager.shared)
          let presenter = ETVNewsPresenterModel(interactor: interactor)
          list.presenter = presenter
        
        return navigationController
    }
    
    
    
    
}
