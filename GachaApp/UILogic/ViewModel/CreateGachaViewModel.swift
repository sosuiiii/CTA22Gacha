import Foundation
import RxCocoa
import RxSwift
import Unio

protocol CreateGachaViewStreamType: AnyObject {
    var input: InputWrapper<CreateGachaViewStream.Input> { get }
    var output: OutputWrapper<CreateGachaViewStream.Output> { get }
}

final class CreateGachaViewStream: UnioStream<CreateGachaViewStream>, CreateGachaViewStreamType {
    convenience init() {
        self.init(input: Input(),
                  state: State(),
                  extra: Extra()
        )
    }
    static func bind(from dependency: Dependency<Input, State, Extra>, disposeBag: DisposeBag) -> Output {
        let input = dependency.inputObservables
//        let state = dependency.state

        input.textField
            .subscribe(onNext: { text, indexPath in
                print(text, indexPath)
            }).disposed(by: disposeBag)

        input.textView
            .subscribe(onNext: { text, indexPath in
                print(text.prefix(10), indexPath)
            }).disposed(by: disposeBag)

        input.pickerView
            .subscribe(onNext: { pickerIndexPath, indexPath in
                print(Const.gachaRarity[pickerIndexPath.row], indexPath)
            }).disposed(by: disposeBag)

        input.registerButtonTapped
            .subscribe(onNext: {
                print("doneButtonTapped")
            }).disposed(by: disposeBag)

        input.updateButtonTapped
            .subscribe(onNext: {
                print("updateButtonTapped")
            }).disposed(by: disposeBag)

        input.deleteButtonTapped
            .subscribe(onNext: {
                print("deleteButtonTapped")
            }).disposed(by: disposeBag)

        return Output(
            datasource: Observable.just([.init(
                items: [
                .init(sectionTitle: "アイテムの名前"),
                .init(sectionTitle: "アイテムの説明"),
                .init(sectionTitle: "レア度"),
                .init(sectionTitle: "作者の名前"),
                .init(sectionTitle: "作者のID")
                ]
            )])
        )
    }
}

extension CreateGachaViewStream {
    struct Input: InputType {
        let textField = PublishRelay<(String, IndexPath)>()
        let textView = PublishRelay<(String, IndexPath)>()
        let pickerView = PublishRelay<((row:Int, component:Int), IndexPath)>()
        let registerButtonTapped = PublishRelay<Void>()
        let updateButtonTapped = PublishRelay<Void>()
        let deleteButtonTapped = PublishRelay<Void>()
    }

    struct Output: OutputType {
        let datasource: Observable<[MockGachaDataSource]>
    }

    struct State: StateType {
        let userNameText = PublishRelay<String>()
        let passwordText = PublishRelay<String>()
        let gachaInfo = PublishRelay<[MockGachaData]>()
    }

    struct Extra: ExtraType {
    }

    struct Const {
        // TODO: モデルに移す
        static let gachaRarity = ["SSR", "SR", "UR", "R", "N"]
    }
}

struct GachaInfo {
    let results: [MockGachaData]
}


