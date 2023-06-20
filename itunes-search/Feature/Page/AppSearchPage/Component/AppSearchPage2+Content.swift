import Foundation
import SwiftUI
import DesignSystem

extension AppSearchPage2 {
  struct ContentComponent {
    let viewState: ViewState
  }
}

extension AppSearchPage2.ContentComponent: View {
  
  var body: some View {
    List {
      ForEach(viewState.items, id: \.self) { title in
        ZStack {
          NavigationLink(destination: AppDetailPage().navigationBarBackButtonHidden(true)) {
            EmptyView()
          }
          .opacity(0)
          
          VStack(alignment: .leading) {
            HStack {
              Image(systemName: "magnifyingglass")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 15, height: 15)
                .foregroundColor(AppColor2.Tint.secondary)
              
              Text(title)
                .font(.system(size: 14, weight: .medium))
            }
            Divider().background(Color.white)
          }
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        .padding(.horizontal, 16)
        .listRowBackground(Color.clear)
      }
    }
    .scrollDismissesKeyboard(.interactively)
    .listStyle(.plain)
  }
}

extension AppSearchPage2.ContentComponent {
  struct ViewState: Hashable {
    let items: [String]
  }
}

