import SwiftUI

struct AppSearchPage {

  @FocusState private var isFocused
  @State private var keyword = ""
  @State private var items: [String] = mock
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
  var header: some View {
    VStack {
      VStack {
        HStack {
          TextField("검색하실 앱의 이름을 적으시오", text: $keyword)
            .textFieldStyle(.plain)
            .focused($isFocused, equals: true)
          if !keyword.isEmpty {
            Button(action: { keyword = "" }) {
              Text("취소")
            }
          }
        }
        .frame(maxHeight: 50)
        .withDefaultPadding(edges: .horizontal)
        .withRoundRect(fillColor: .white, cornerRadius: 8, strokeColor: .black, strokeWidth: 1)
      }
    }
    .withDefaultPadding()
    .background(keyword.isEmpty ? .blue : .gray)
    .animation(.easeInOut, value: keyword)
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
      header
      content
    }
    .background(.white)
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

