import Foundation
import SwiftUI

public struct AppTextField {
  let text: Binding<String>
  let placeHolder: String?
  // 사용자가 무언가 Action을 취했을때 다른 것을 못하게 하기 위한 프로퍼티
  let isDisabled: Bool
  
  public init(text: Binding<String>, placeHolder: String?, isDisabled: Bool) {
    self.text = text
    self.placeHolder = placeHolder
    self.isDisabled = isDisabled
  }
}

extension AppTextField: View {
  
  public var body: some View {
    TextField("", text: text)
      .placeholder(when: text.wrappedValue.isEmpty) {
        Text(placeHolder ?? "")
          .foregroundColor(AppColor.Label.base)
        
      }
      .disabled(isDisabled)
  }
}

extension View {
  fileprivate func placeholder<Content: View>(
    when shouldShow: Bool,
    alignment: Alignment = .leading,
    @ViewBuilder placeholder: () -> Content) -> some View {
      
      ZStack(alignment: alignment) {
        placeholder().opacity(shouldShow ? 1 : 0)
        self
      }
    }
}
