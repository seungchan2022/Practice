import Foundation
import Domain

struct EndpointBuilder {
  let remoteClient: RemoteClient
  
  init(remoteClient: RemoteClient) {
    self.remoteClient = remoteClient
  }
}

extension EndpointBuilder {
  func send<T: Decodable>(endpoint: Endpoint) async throws -> T {
    guard let urlComponent = URLComponents.generate(baseURL: endpoint.url, parameter: endpoint.parameter),
          let url = urlComponent.url
    else { throw CompositeError.invalidTypeCast }
    
    let data = try await remoteClient.send(url: url)
    return try JSONDecoder().decode(T.self, from: data)
  }
}

extension URLComponents {
  fileprivate static func generate(baseURL: String, parameter: QueryParameterType) -> Self? {
    var component = URLComponents(string: baseURL)
    component?.queryItems = parameter.makeQuery().map {
      URLQueryItem(name: $0.key, value: $0.value)
    }
    return component
  }
}
