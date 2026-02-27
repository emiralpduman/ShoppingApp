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
        guard let url = URL(string: "https://fakestoreapi.com") else {
            fatalError("Invalid base URL")
        }
        return url
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

    public var headers: [String: String]? {
        nil
    }
}
