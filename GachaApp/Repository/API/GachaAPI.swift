//
//  GachaAPI.swift
//  GachaApp
//
//  Created by 田中 颯志 on 2022/03/03.
//

import Foundation
import Moya
import RxSwift

struct MockGacha {
    let list: [String]
    
    init(list: [String]) {
        self.list = list
    }
}

struct MockError: Error {}

final class GachaAPI {
    private let apiProvider = MoyaProvider<GachaTarget>()
}

extension GachaAPI: GachaAPIType {
    func get(result: Result<Void, Error>) -> Single<MockGacha> {
        return Single<MockGacha>.create { observer in
            switch result {
            case .success:
                observer(.success(MockGacha(list: ["mock", "mock2"])))
            case .failure:
                observer(.failure(MockError()))
            }
            return Disposables.create()
        }
    }
}
