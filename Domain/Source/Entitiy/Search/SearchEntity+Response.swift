import Foundation

extension SearchEntity {
  public enum Response: Equatable { }
}

extension SearchEntity.Response {
  public struct Result: Decodable, Equatable {
    let count: Int
    public let resultList: [Item]
    
    private enum CodingKeys: String, CodingKey {
      case count = "resultCount"
      case resultList = "results"
    }
    
    public init(count: Int, resultList: [Item]) {
      self.count = count
      self.resultList = resultList
    }
  }
}

extension SearchEntity.Response.Result {
  public struct Item: Decodable, Equatable, Identifiable {
    let trackId: Int
    public let trackName: String
    let primaryGenreName: String
    let averageUserRating: Float?
    let screenshotUrls: [String]?
    let artworkUrl100: String
    let formattedPrice: String?
    let description: String?
    let releaseNotes: String?
    let artistName: String?
    let collectionName: String?
    
    public var id: Int { trackId }
    
    public init(
      trackId: Int,
      trackName: String,
      primaryGenreName: String,
      averageUserRating: Float?,
      screenshotUrls: [String]?,
      artworkUrl100: String,
      formattedPrice: String?,
      description: String?,
      releaseNotes: String?,
      artistName: String?,
      collectionName: String?)
    {
      self.trackId = trackId
      self.trackName = trackName
      self.primaryGenreName = primaryGenreName
      self.averageUserRating = averageUserRating
      self.screenshotUrls = screenshotUrls
      self.artworkUrl100 = artworkUrl100
      self.formattedPrice = formattedPrice
      self.description = description
      self.releaseNotes = releaseNotes
      self.artistName = artistName
      self.collectionName = collectionName
    }
  }
}
