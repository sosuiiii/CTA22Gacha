import Foundation
import RxCocoa
import RxSwift
import Unio

protocol RegisterUserViewStreamType: AnyObject {
    var input: InputWrapper<RegisterUserViewStream.Input> { get }
    var output: OutputWrapper<RegisterUserViewStream.Output> { get }
}

final class RegisterUserViewStream: UnioStream<RegisterUserViewStream>, RegisterUserViewStreamType {
    convenience init() {
        self.init(input: Input(),
                  state: State(),
                  extra: Extra()
        )
    }
    static func bind(from dependency: Dependency<Input, State, Extra>, disposeBag: DisposeBag) -> Output {
        let input = dependency.inputObservables
//        let state = dependency.state

        input.userNameText
            .subscribe(onNext: { text in
                print(text)
            }).disposed(by: disposeBag)

        input.passwordText
            .subscribe(onNext: { text in
                print(text)
            }).disposed(by: disposeBag)

        input.registerButtonTapped
            .withLatestFrom(Observable.combineLatest(input.userNameText, input.passwordText))
            .subscribe(onNext: { username, password in
                print(username, password)
            }).disposed(by: disposeBag)

        return Output()
    }
}

extension RegisterUserViewStream {
    struct Input: InputType {
        let userNameEditingChanged = PublishRelay<Void>()
        let userNameText = PublishRelay<String>()
        let passwordEditingChanged = PublishRelay<Void>()
        let passwordText = PublishRelay<String>()
        let registerButtonTapped = PublishRelay<Void>()
    }

    struct Output: OutputType {
    }

    struct State: StateType {
        let userNameText = PublishRelay<String>()
        let passwordText = PublishRelay<String>()
    }

    struct Extra: ExtraType {
    }
}




