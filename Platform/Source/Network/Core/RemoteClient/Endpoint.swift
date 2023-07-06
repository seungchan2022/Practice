import Foundation

struct Endpoint {
  let url: String
  let parameter: any QueryParameterType & Equatable
}

extension Endpoint: Equatable {
  static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.url == rhs.url
    && lhs.parameter.makeQuery() == rhs.parameter.makeQuery()
  }
}
