//
//  GachaListViewModel.swift
//  GachaApp
//
//  Created by 化田晃平 on 2022/03/05.
//

import Foundation
import RxRelay
import RxSwift
import Unio

protocol GachaListViewStreamType: AnyObject {
    var input: InputWrapper<GachaListViewStream.Input> { get }
    var output: OutputWrapper<GachaListViewStream.Output> { get }
}

final class GachaListViewStream: UnioStream<GachaListViewStream>, GachaListViewStreamType {

    convenience init() {
        self.init(
            input: Input(),
            state: State(),
            extra: Extra()
        )
    }

    static func bind(from dependency: Dependency<Input, State, Extra>, disposeBag: DisposeBag) -> Output {
        let input = dependency.inputObservables
        let state = dependency.state
        let extra = dependency.extra

        let segmentIndexStream = Observable.merge(
            input.viewDidLoad.withLatestFrom(input.segmentIndex),
            input.refresh.withLatestFrom(input.segmentIndex),
            input.segmentIndex
        )

        // TODO: APIを繋いだらdelay消す（非同期通信はわざと2秒delayをかけている。）
        let gachaListEvent = segmentIndexStream
            .filter { $0 == 0 }
            .delay(.seconds(2), scheduler: MainScheduler.instance)
            .flatMap { _ in
//                Observable.just(["11111", "22222", "33333"])
                Observable<[String]>.error(NSError(domain: "通信エラー", code: -1, userInfo: nil))
                    .materialize()
            }
            .share()

        let myGachaListEvent = segmentIndexStream
            .filter { $0 == 1 }
            .delay(.seconds(2), scheduler: MainScheduler.instance)
            .flatMap { _ in
                Observable.just(["11111", "22222"])
                    .materialize()
            }
            .share()

        // 通信の有無（通信開始時: true, 通信終了時: false）
        Observable.merge(
            segmentIndexStream.map { _ in true },
            gachaListEvent.map { _ in false },
            myGachaListEvent.map { _ in false }
        )
        .bind(to: state.isConnecting)
        .disposed(by: disposeBag)


        Observable.merge(gachaListEvent, myGachaListEvent)
            .flatMap { $0.element.map(Observable.just) ?? .empty() }
            .bind(to: state.gachaList)
            .disposed(by: disposeBag)

        Observable.merge(gachaListEvent, myGachaListEvent)
            .flatMap { $0.error.map(Observable.just) ?? .empty() }
            .do(onNext: { _ in
                state.gachaList.accept([])
            })
            .bind(to: state.error)
            .disposed(by: disposeBag)

            return Output(
                error: state.error.asObservable(),
                gachaList: state.gachaList.asObservable(),
                isConnecting: state.isConnecting.asObservable()
            )
    }
}

extension GachaListViewStream {
    struct Input: InputType {
        let viewDidLoad = PublishRelay<Void>()
        let refresh = PublishRelay<Void>()
        let segmentIndex = PublishRelay<Int>()
    }

    struct Output: OutputType {
        let error: Observable<Error>
        let gachaList: Observable<[String]>
        let isConnecting: Observable<Bool>
    }

    struct State: StateType {
        let error = PublishRelay<Error>()
        let gachaList = PublishRelay<[String]>()
        let isConnecting = PublishRelay<Bool>()
    }

    struct Extra: ExtraType {
    }
}
