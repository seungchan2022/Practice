import DesignSystem
import SwiftUI
import Foundation

extension AppSearchPage {
  struct HeaderComponent {
    let viewState: ViewState
    let text: Binding<String>
    let isFocused: FocusState<Bool>.Binding
    let clearAction: () -> Void
    let searchAction: () -> Void
  }
}

extension AppSearchPage.HeaderComponent: View {
  
  var body: some View {
    VStack {
      VStack {
        HStack {
          AppTextField(
            text: text,     // 그냥 text라고 적은 것은 작성하는 text 가 Binding<String> 이라는 것이고,
            placeHolder: viewState.placeHolder,
            isDisabled: false)
          .focused(isFocused, equals: true)
          
          if !text.wrappedValue.isEmpty {
            Button(action: clearAction ) {  // .wrappedValue로 감싼것은 바인딩의 실제값?
              Text("취소")      // text에 바인딩 된값을 넣어야 되고, 넣으면 다음과 같이 로직이 수행 된다 ??
            }
            .tint(AppColor.Label.base)
          }
        }
        .frame(maxHeight: 50)
        .withDefaultPadding(edges: .horizontal)
        .withRoundRect(
          fillColor: AppColor.Background.base,
          cornerRadius: 8,
          strokeColor: AppColor.Tint.secondary,
          strokeWidth: 1)
      }
    }
    .withDefaultPadding()
    .background(AppColor.Tint.primary)
    .animation(.easeInOut, value: text.wrappedValue)
  }
}

extension AppSearchPage.HeaderComponent {
  struct ViewState: Equatable {
    let placeHolder: String
  }
}
