import Foundation
import RxSwift
import Unio

protocol RegisterUserViewStreamType: AnyObject {
}

final class RegisterUserViewStream: UnioStream<RegisterUserViewStream>, RegisterUserViewStreamType {
    static func bind(from dependency: Dependency<Input, State, Extra>, disposeBag: DisposeBag) -> Output {
        return Output()
    }
}

extension RegisterUserViewStream {
    struct Input: InputType {
    }

    struct Output: OutputType {
    }

    struct State: StateType {
    }

    struct Extra: ExtraType {
    }
}




