import Foundation
import Domain

public struct SearchUseCasePlatform {
  
  let remoteClient: RemoteClient
  
  public init(remoteClient: RemoteClient) {
    self.remoteClient = remoteClient
  }
}

extension SearchUseCasePlatform {
  struct Constant {
    static let baseURL = "https://itunes.apple.com/search"
  }
}

extension SearchUseCasePlatform: SearchUseCaseDomain {
  public var search: (SearchEntity.Request.Keyword) async throws -> SearchEntity.Response.Result {
    {
      try await EndpointBuilder(remoteClient: remoteClient)
        .send(endpoint: .init(url: Constant.baseURL, parameter: $0))
    }
  }
}

extension SearchEntity.Request.Keyword: QueryParameterType {
  func makeQuery() -> [String : String] {
    [
      "term": term,
      "software": software,
    ]
  }
}
