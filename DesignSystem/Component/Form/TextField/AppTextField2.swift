import Foundation
import SwiftUI

public struct AppTextField2 {
  let text: Binding<String>
  let placeHolder: String?
  let isDisabled: Bool
  
  public init(text: Binding<String>, placeHolder: String?, isDisabled: Bool) {
    self.text = text
    self.placeHolder = placeHolder
    self.isDisabled = isDisabled
  }
}

extension AppTextField2: View {
  
  public var body: some View {
    TextField("", text: text)
      .placeholder(when: text.wrappedValue.isEmpty) {
        Text(placeHolder ?? "")
          .foregroundColor(AppColor2.Label.base)
        
      }
      .disabled(isDisabled)
  }
}

// placeholder의 color를 바꾸기 위해
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

