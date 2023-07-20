//
//  Router.swift
//  CryptoViper
//
//  Created by eyüp yaşar demir on 7.07.2023.
//

import Foundation
import UIKit

typealias entryPoint = AnyView & UIViewController

protocol  AnyRoter{
    var entry : entryPoint? { get }
    static func startExecution() -> AnyRoter
}

class CryptoRoter : AnyRoter {
    var entry: entryPoint?
    
    static func startExecution() -> AnyRoter {
        let roter = CryptoRoter()
        
        var view : AnyView = CryptoViewController()
        var presenter : AnyPresenter = CryptoPresenter()
        var interactor : AnyInteractor = CryptoInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.roter = roter
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        roter.entry = view as? entryPoint
        return roter
    }
    
    
}
