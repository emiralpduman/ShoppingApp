//
//  FakeStoreService.swift
//  Shopping App API
//
//  Created by Emiralp Duman on 3.11.2022.
//

import Foundation
import Moya

public let fakeStoreAPI = MoyaProvider<FakeStoreService>()

public enum FakeStoreService {
    case getProducts
}

extension FakeStoreService: TargetType {
    public var baseURL: URL {
        return URL(string: "https://fakestoreapi.com")!
    }
    
    public var path: String {
        switch self {
        case .getProducts:
            return "/products"
        }
    }
    
    public var method: Moya.Method {
        .get
    }
    
    public var task: Moya.Task {
        switch self {
        case .getProducts:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        nil
    }
}
