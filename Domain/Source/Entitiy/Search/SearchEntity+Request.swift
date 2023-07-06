import Foundation

extension SearchEntity {
  public enum Request: Equatable { }
}

extension SearchEntity.Request {
  public struct Keyword: Equatable {
    public let term: String
    public let software: String
    
    public init(term: String, software: String = "software") {
      self.term = term
      self.software = software
    }
  }
}
