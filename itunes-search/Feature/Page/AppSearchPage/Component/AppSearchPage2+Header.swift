import Foundation
import SwiftUI
import DesignSystem

extension AppSearchPage2 {
  struct HeaderComponent {
    let viewState: ViewState
    let text: Binding<String>
    let isFocused: FocusState<Bool>.Binding
    let clearAction: () -> Void
    let searchAction: () -> Void
  }
}

extension AppSearchPage2.HeaderComponent: View {
  
  var body: some View  {
    VStack {
      HStack {
        Spacer()
        HStack {
          Image(systemName: "magnifyingglass")
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 15, height: 15)
            .foregroundColor(AppColor2.Tint.secondary)
          
          AppTextField2(text: text,
                        placeHolder: viewState.placeHolder,
                        isDisabled: false)
          .focused(isFocused, equals: true)
          
          if !text.wrappedValue.isEmpty {
            Button(action: clearAction ) {
              Image(systemName: "xmark.circle.fill")
                .imageScale(.large)
                .frame(width: 15, height: 15)
                .foregroundColor(AppColor2.Tint.secondary)
            }
          }
        }
        .frame(width: 280 ,height: 35)
        .padding(.horizontal, 16)
        .background(
          RoundedRectangle(cornerRadius: 8)
            .fill(AppColor2.Background.base3)
        )
        
        Spacer()
        
        Button(action: clearAction ) {
          Text("취소")
            .font(.system(size: 18, weight: .medium))
            .foregroundColor(AppColor2.Tint.primary)
        }
        
        Spacer()
      } // HStack
    } // VStack
    .padding(.top, 10)
    .padding(.horizontal, 5)
  }
}

extension AppSearchPage2.HeaderComponent {
  struct ViewState: Equatable {
    let placeHolder: String
  }
}
