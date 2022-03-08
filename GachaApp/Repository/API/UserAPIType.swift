import RxSwift

protocol UserAPIType {
    func get(result: Result<Void, Error>) -> Single<MockUser>
}
