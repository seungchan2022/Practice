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
      ForEach(viewState.post, id: \.self) { post in
        AppDetailListPage(post: post)
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
