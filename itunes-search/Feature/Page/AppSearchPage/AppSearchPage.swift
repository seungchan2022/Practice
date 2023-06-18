import SwiftUI
import DesignSystem

struct AppSearchPage {
  
  @FocusState private var isFocused
  @State private var keyword = ""
  @State private var items: [String] = mock
}

extension AppSearchPage {
  var HeaderComponentViewState: HeaderComponent.ViewState {
    .init(placeHolder: "검색할 앱을 적으시오.")
  }
}

extension AppSearchPage: View {
  
  var filter: (String) -> [String] {
    { text in
      mock.filter{
        $0.lowercased().contains(text.lowercased())
      }
    }
  }
  
  @ViewBuilder
  var content: some View {
    List {
      ForEach(items, id: \.self) { title in
        HStack {
          Text(title)
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.white)
        .listRowInsets(EdgeInsets())
        .withDefaultPadding(edges: .horizontal)
      }
    }
    .listStyle(.plain)
    .animation(.spring(), value: items)
  }
  
  var body: some View {
    VStack(spacing: .zero) {
      HeaderComponent(
        viewState: HeaderComponentViewState,
        text: $keyword,
        isFocused: $isFocused,
        clearAction: { keyword = "" },
        searchAction: { print("DEBUG: 검색") })
      content
    }
    .background(AppColor.Background.base)
    .onAppear {
            print(items)
    }
    .onTapGesture {
      isFocused = false
    }
    .onChange(of: keyword) {
      items = keyword.isEmpty ? mock : filter($0)
    }
  }
}


extension View {
  func withRoundRect(
    fillColor: Color,
    cornerRadius: CGFloat,
    strokeColor: Color,
    strokeWidth: CGFloat? = .none) -> some View
  {
    background(
      RoundedRectangle(cornerRadius: cornerRadius)
        .stroke(strokeColor, lineWidth: strokeWidth ?? .zero)
        .background(
          RoundedRectangle(cornerRadius: 8)
            .fill(fillColor)
        )
    )
  }

  func withDefaultPadding(edges: Edge.Set = .all) -> some View {
    padding(edges, 16)
  }
}

let mock: [String] = [
  "camera",
  "games"
]

