import Foundation
import Moya

enum UserTarget {
    /// ユーザー登録
    case register
    /// ユーザー情報参照
    case getUserInfo(id: String)
    /// ユーザー情報変更
    case updateUserInfo(id: String)
    /// ユーザー所持アイテム一覧
    case items(id: String)
}

extension UserTarget: TargetType {
    var baseURL: URL {
        return URL(string: "https://webservice.recruit.co.jp/")!
    }

    var path: String {
        switch self {
        case .register:
            return "/user"
        case .getUserInfo(let id):
            return "/user/\(id)"
        case .updateUserInfo(let id):
            return "/user/\(id)"
        case .items(let id):
            return "/user/\(id)/items"
        }
    }

    var method: Moya.Method {
        switch self {
        case .register:
            return .post
        case .getUserInfo:
            return .get
        case .updateUserInfo:
            return .patch
        case .items:
            return .get
        }

    }

    var sampleData: Data {
        return Data()
    }
    var parameters: [String: Any] {
        return [:]
    }
    var parameterEncoding: ParameterEncoding {
        return Moya.URLEncoding.queryString
    }

    var task: Task {
        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
