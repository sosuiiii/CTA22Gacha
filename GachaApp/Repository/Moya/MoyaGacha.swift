import Foundation
import Moya

enum GachaTarget {
    /// ガチャ一覧
    case list
    /// ガチャ作成
    case create
    /// ガチャ詳細表示
    case detail(id: String)
    /// ガチャ実行
    case execute(id: String)
    /// ガチャ仕様変更
    case update(id: String)
    /// ガチャ削除
    case delete(id: String)
    /// アイテム一覧
    case itemList(id: String)
}

extension GachaTarget: TargetType {
    var baseURL: URL {
        return URL(string: "https://webservice.recruit.co.jp/")!
    }
    
    var path: String {
        switch self {
        case .list:
            return "/gacha"
        case .create:
            return "/gacha"
        case .detail(let id):
            return "/gacha/\(id)"
        case .execute(let id):
            return "/gacha\(id)"
        case .update(let id):
            return "/gacha/\(id)"
        case .delete(let id):
            return "/gacha/\(id)"
        case .itemList(let id):
            return "/gacha/\(id)/items"
        }
            
    }
    
    var method: Moya.Method {
        switch self {
        case .list:
            return .get
        case .create:
            return .post
        case .detail:
            return .get
        case .execute:
            return .post
        case .update:
            return .put
        case .delete:
            return .delete
        case .itemList:
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
