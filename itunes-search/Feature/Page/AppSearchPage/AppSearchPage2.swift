import SwiftUI
import DesignSystem

struct AppSearchPage2 {
  
  @State private var keyword = ""
  @State private var items: [String] = mock2
  // 필터링된 아이템들을 담기 위해
  @State private var filteredItems = [String]()
  // textField를 선택하면 키보드가 나오게 하기 위해
  @FocusState private var isFocused
}

extension AppSearchPage2 {
  var HeaderComponentViewState: HeaderComponent.ViewState {
    .init(placeHolder: "검색할 앱을 적으시오.")
  }
}

extension AppSearchPage2 {
  
  var ContentComponentViewState: ContentComponent.ViewState {
    .init(items: filteredItems)
  }
}

extension AppSearchPage2: View {
  var body: some View {
    NavigationView {
      VStack(spacing: 20) {
        HeaderComponent(
          viewState: HeaderComponentViewState,
          text: $keyword,
          isFocused: $isFocused,
          clearAction: { keyword = "" },
          searchAction: { print("DEBUG: 검색") }
        )
        ContentComponent(viewState: ContentComponentViewState)
      }
      .background(AppColor2.Background.base)
      .onChange(of: keyword) { newKeyword in
        updateFilteredItems()
      }
    }
    .onAppear {
      updateFilteredItems()
    }
  }
  
  // 아무것도 입력을 안하면 모든 리스트를 보여주고, 입력을 하면 필터링된 리스트를 보여주기 위해
  private func updateFilteredItems() {
    if keyword.isEmpty {
      filteredItems = items
    } else {
      filteredItems = items.filter {
        $0.lowercased().contains(keyword.lowercased())
      }
    }
  }
}

let mock2: [String] = [
  "방탈출",
  "방탈출게임",
  "방치형",
  "방 구하기",
  "전국방탈출",
  "EndlessRooms",
  "HeartlessRoom",
  "Escape Rooms",
  "방탈출 : 탈출 게임",
  "탈출 게임",
  "방탈출 퍼즐 게임",
  "방탈출 스토리 게임",
  "방탈출 미스터리 게임",
]

struct AppDetailPage {
  @State private var keyword = "방탈출"
  
  // textField를 선택하면 키보드가 나오게 하기 위해
  @FocusState private var isFocused
  @Environment(\.dismiss) var dismiss
}

extension AppDetailPage {
  var HeaderComponentViewState: HeaderComponent.ViewState {
    .init(placeHolder: "검색할 앱을 적으시오.")
  }
}

extension AppDetailPage {
  var ContentComponentViewState: ContentComponent.ViewState {
    .init(post: Post.MOCK_POSTS)
  }
}

extension AppDetailPage: View {
  
  var body: some View {
    VStack(spacing: .zero) {
      HeaderComponent(viewState: HeaderComponentViewState,
                      text: $keyword,
                      isFocused: $isFocused,
                      clearAction: { dismiss() },
                      searchAction: { print("DEBUG: 검색")})
      ContentComponent(viewState: ContentComponentViewState)
    }
    .onTapGesture {
      isFocused = false
    }
  }
}

struct AppDetailListPage {
  let post: Post
}

extension AppDetailListPage {
  var ContentComponentViewState: ContentComponent.ViewState {
    .init(post: post)
  }
}

extension AppDetailListPage: View {
  
  var body: some View {
    ContentComponent(viewState: ContentComponentViewState)
  }
}

struct Post: Hashable {
  let thumbnail: String
  let title: String
  let explantion: String
  let stars: String
  let evaluation: String
  //    let    버튼
  let pathOfPurchase: String
  let imageDescriptions: String
}

extension Post {
  
  static var MOCK_POSTS: [Post] = [
    .init(
      thumbnail: "image1",
      title: "방탈출 - Escape Rooms",
      explantion: "인기 방탈출 게임",
      stars: "star.fill",
      evaluation: "5.4천",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image2"
    ),
    .init(
      thumbnail: "image2",
      title: "탈출 게임 The Lake View",
      explantion: "당신은 여기서 탈출할 수 있습니까 ?",
      stars: "star.fill",
      evaluation: "622",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image3"
    ),
    .init(
      thumbnail: "image3",
      title: "노바디즈: 시체 처리반",
      explantion: "시체를 숨기로 흔적을 남기지 마십시오.",
      stars: "star.fill",
      evaluation: "1.8만",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image4"
    ),
    .init(
      thumbnail: "image4",
      title: "탈출 게임 Onsen",
      explantion: "어드벤처",
      stars: "star.fill",
      evaluation: "363",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image5"
    ),
    .init(
      thumbnail: "image5",
      title: "노바디즈: 사후세계",
      explantion: "시체를 숨기로 흔적을 남기지 마십시오.",
      stars: "star.fill",
      evaluation: "1.9천",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image6"
    ),
    .init(
      thumbnail: "image6",
      title: "방탈출: 탈출게임",
      explantion: "탈출 게임",
      stars: "star.fill",
      evaluation: "295",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image7"
    ),
    .init(
      thumbnail: "image7",
      title: "노바디즈: 사후세계",
      explantion: "시체를 숨기로 흔적을 남기지 마십시오.",
      stars: "star.fill",
      evaluation: "1.9천",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image8"
    ),
    .init(
      thumbnail: "image8",
      title: "노바디즈: 사후세계",
      explantion: "시체를 숨기로 흔적을 남기지 마십시오.",
      stars: "star.fill",
      evaluation: "1.9천",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image9"
    ),
    .init(
      thumbnail: "image9",
      title: "노바디즈: 사후세계",
      explantion: "시체를 숨기로 흔적을 남기지 마십시오.",
      stars: "star.fill",
      evaluation: "1.9천",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image10"
    ),
    .init(
      thumbnail: "image10",
      title: "노바디즈: 사후세계",
      explantion: "시체를 숨기로 흔적을 남기지 마십시오.",
      stars: "star.fill",
      evaluation: "1.9천",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image11"
    ),
    .init(
      thumbnail: "image11",
      title: "노바디즈: 사후세계",
      explantion: "시체를 숨기로 흔적을 남기지 마십시오.",
      stars: "star.fill",
      evaluation: "1.9천",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image12"
    ),
    .init(
      thumbnail: "image12",
      title: "노바디즈: 사후세계",
      explantion: "시체를 숨기로 흔적을 남기지 마십시오.",
      stars: "star.fill",
      evaluation: "1.9천",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image13"
    ),
    .init(
      thumbnail: "image13",
      title: "노바디즈: 사후세계",
      explantion: "시체를 숨기로 흔적을 남기지 마십시오.",
      stars: "star.fill",
      evaluation: "1.9천",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image14"
    ),
    .init(
      thumbnail: "image14",
      title: "노바디즈: 사후세계",
      explantion: "시체를 숨기로 흔적을 남기지 마십시오.",
      stars: "star.fill",
      evaluation: "1.9천",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image15"
    ),
    
  ]
}

