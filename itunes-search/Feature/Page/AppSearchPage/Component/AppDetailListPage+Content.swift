import Foundation
import SwiftUI
import DesignSystem

extension AppDetailListPage {
  struct ContentComponent {
    let viewState: ViewState
  }
}

extension AppDetailListPage.ContentComponent: View {
  
  var body: some View {
    VStack {
      HStack {
        Image(viewState.post.thumbnail)
          .resizable()
          .scaledToFill()
          .frame(width: 60, height: 60)
          .cornerRadius(20)
        VStack(alignment: .leading, spacing: 5) {
          Text(viewState.post.title)
            .font(.system(size: 14, weight: .bold))
          Text(viewState.post.explantion)
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(AppColor2.Label.base)
          HStack(spacing: 4) {
            ForEach(0 ..< 5, id: \.self) { star in
              Image(systemName: viewState.post.stars)
                .renderingMode(.template)
                .resizable()
                .scaledToFill()
                .frame(width: 10, height: 10)
            }
            Text(viewState.post.evaluation)
              .font(.system(size: 12, weight: .ultraLight))
          }
          .foregroundColor(AppColor.Tint.secondary)
        }
        
        Spacer()
        
        VStack(spacing: 5) {
          Button {
            // => 버튼만 눌렀을대 실행이 되야 된는데 왜 모든 곳을 눌러도 실행이 되는건가??
            print("DEBUG: Did tap button..")
          } label: {
            Text("받기")
              .font(.system(size: 14, weight: .bold))
              .foregroundColor(AppColor2.Tint.primary)
              .frame(width: 80, height: 30)
              .background(
                RoundedRectangle(cornerRadius: 20)
                  .fill(AppColor2.Background.base2)
              )
          }
          Text(viewState.post.pathOfPurchase)
            .font(.system(size: 10, weight: .light))
            .foregroundColor(AppColor2.Label.base)
        }
        .padding(.top, 20)
      }
      
      Group {
        HStack(spacing: 10) {
          // => 인덱스가 짝수이면 하나의 이미지 설명, 홀수이면 3개의 이미지 설명이 나오도록 설정
          if let index = Post.MOCK_POSTS.firstIndex(of: viewState.post) {
            if index % 2 == 0 {
              Image(viewState.post.imageDescriptions)
                .resizable()
                .scaledToFill()
                .frame(width: (UIScreen.main.bounds.width - 20), height: (UIScreen.main.bounds.width / 2) + 30)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
              ForEach(0 ..< 3, id: \.self) { index in
                // 이미지가 랜덤으로 3개가 선택되도록
                let randomIndex = Int.random(in: 1 ..< 13)
                Image("image\(randomIndex + index)")
                  .resizable()
                  .scaledToFill()
                  .frame(width: (UIScreen.main.bounds.width - 40) / 3, height: ((UIScreen.main.bounds.width - 40) / 3) * 2)
                  .clipShape(RoundedRectangle(cornerRadius: 10))
              }
            }
          }
        }
      }
      .padding(.top)
      
    }
    .padding(.horizontal, 10)
    .padding(.vertical, 20)
  }
}

extension AppDetailListPage.ContentComponent {
  struct ViewState: Hashable {
    let post: Post
  }
}
