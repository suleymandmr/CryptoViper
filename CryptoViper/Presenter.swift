//
//  Presenter.swift
//  CryptoViper
//
//  Created by eyüp yaşar demir on 7.07.2023.
//

import Foundation

enum NetworkError : Error {
    case NetworkFailed
    case ParsingFailed
}

protocol AnyPresenter {
    var roter : AnyRoter? { get set }
    var interactor : AnyInteractor? { get set }
    var view : AnyView? { get set }
    
    func interactorDidDowloadCrypto(result : Result<[Crypto] , Error>)
}

class CryptoPresenter : AnyPresenter {
    var roter: AnyRoter?
    
    var interactor: AnyInteractor?{
        didSet{
            interactor?.downloadCryptos()
        }
    }
    
    var view: AnyView?
    
    func interactorDidDowloadCrypto(result: Result<[Crypto], Error>) {
        switch result {
        case.success(let cryptos):
            view?.update(with: cryptos)
        case.failure(_):
            view?.update(with: "Try again later...")
            
        }
    }
    
    
    
    
}
