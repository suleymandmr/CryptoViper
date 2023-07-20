//
//  Interactor.swift
//  CryptoViper
//
//  Created by eyüp yaşar demir on 7.07.2023.
//

import Foundation

protocol AnyInteractor{
    var presenter : AnyPresenter? { get set }
    
    func downloadCryptos()
}

class CryptoInteractor : AnyInteractor {
    var presenter: AnyPresenter?
    
    func downloadCryptos() {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data ,error == nil else{
                self?.presenter?.interactorDidDowloadCrypto(result: .failure(NetworkError.NetworkFailed))
                return
            }
            do{
                let cryptos = try JSONDecoder().decode([(Crypto)].self, from: data)
                self?.presenter?.interactorDidDowloadCrypto(result: .success(cryptos))
            }catch{
                self?.presenter?.interactorDidDowloadCrypto(result: .failure(NetworkError.ParsingFailed))
            }
        }
        task.resume()
    }
    
    
}
