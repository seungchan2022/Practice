import Foundation
import SwiftUI
import DesignSystem

extension AppDetailPage {
  struct HeaderComponent {
    let viewState: ViewState
    let text: Binding<String>
    let isFocused: FocusState<Bool>.Binding
    let clearAction: () -> Void
    let searchAction: () -> Void
  }
}

extension AppDetailPage.HeaderComponent: View {
  
  var body: some View  {
    VStack(spacing: 10) {
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
              .fill(.gray.opacity(0.2))
          )
          
          Spacer()
          
          Button(action: clearAction ) {
            Text("취소")
              .font(.system(size: 18, weight: .medium))
              .foregroundColor(AppColor2.Tint.primary)
          }
          
          Spacer()
        } // HStack
        
        HStack {
          Button {
            print("DEBUG: 공포 버튼")
          } label: {
            Text("공포")
              .font(.system(size: 16, weight: .medium))
              .foregroundColor(.blue)
              .frame(width: 60, height: 30)
              .background(
                RoundedRectangle(cornerRadius: 20)
                  .stroke(.gray.opacity(0.5), lineWidth: 1)
                  .background(
                    RoundedRectangle(cornerRadius: 20)
                      .fill(Color.clear))
              )
          }
          
          Spacer()
        }
        .padding(.horizontal, 10)
        
      } // VStack
    } // vstack
    .padding(.top, 10)
    .padding(.bottom, 10)
    .padding(.horizontal, 10)
    
  }
}

extension AppDetailPage.HeaderComponent {
  struct ViewState: Equatable {
    let placeHolder: String
  }
}

