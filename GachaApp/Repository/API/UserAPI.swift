import Moya
import RxSwift

struct MockUser {
    let name: String
    init(name: String) {
        self.name = name
    }
}
struct MockError: Error {}

final class UserAPI {
    private let apiProvider = MoyaProvider<UserTarget>()
}

extension UserAPI: UserAPIType {
    func get(result: Result<Void, Error>) -> Single<MockUser> {
        return Single<MockUser>.create { observer in
            switch result {
            case .success:
                observer(.success(MockUser(name: "mock")))
            case .failure:
                observer(.failure(MockError()))
            }
            return Disposables.create()
        }
    }
}

// API繋ぎこみで使う
//enum UserAPIError: Error {
//    case decodeError
//    case responseError
//}
