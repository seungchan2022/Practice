import Foundation
import SwiftUI
import DesignSystem

extension AppDetailPage {
  struct ContentComponent {
    let viewState: ViewState
  }
}


extension AppDetailPage.ContentComponent: View {
  var body: some View {
    List {
      ForEach(Post.MOCK_POSTS, id: \.self) { post in
        DetailCellView(post: post)
      }
      .listRowSeparator(.hidden)
      .listRowInsets(EdgeInsets())
    }
    .background(AppColor2.Background.base)
    .listStyle(.plain)
    .scrollDismissesKeyboard(.interactively)
  }
}

extension AppDetailPage.ContentComponent {
  struct ViewState: Hashable {
    let post: [Post]
  }
}
