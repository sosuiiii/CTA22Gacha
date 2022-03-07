import RxSwift

protocol GachaAPIType {
    func get(result: Result<Void, Error>) -> Single<MockGacha>
}
