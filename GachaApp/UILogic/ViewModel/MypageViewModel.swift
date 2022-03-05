//
//  MypageViewModel.swift
//  GachaApp
//
//  Created by 化田晃平 on 2022/03/05.
//

import Foundation
import RxSwift
import Unio

protocol MypageViewStreamType: AnyObject {
}

final class MypageViewStream: UnioStream<MypageViewStream>, MypageViewStreamType {
    static func bind(from dependency: Dependency<Input, State, Extra>, disposeBag: DisposeBag) -> Output {
        return Output()
    }
}

extension MypageViewStream {
    struct Input: InputType {
    }

    struct Output: OutputType {
    }

    struct State: StateType {
    }

    struct Extra: ExtraType {
    }
}




