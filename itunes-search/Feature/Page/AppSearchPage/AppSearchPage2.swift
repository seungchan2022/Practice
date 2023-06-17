import SwiftUI

struct AppSearchPage2 {
  
  @State private var keyword = ""
  @State private var items: [String] = mock2
  // textField를 선택하면 키보드가 나오게 하기 위해
  @FocusState private var isFocused
}

extension AppSearchPage2: View {
  
  // 검색을 하면 검색한 텍스트에 따라 필터링 되도록 -> 대소문자 구분없이 검색
  var filter: (String) -> [String] {
    { text in
      mock2.filter{
        $0.lowercased().contains(text.lowercased())
      }
    }
  }
  
  @ViewBuilder
  var header: some View {
    VStack {
      HStack {
        
        Spacer()
        
        HStack {
          Image(systemName: "magnifyingglass")
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 15, height: 15)
            .foregroundColor(.gray)
          
          TextField("검색하실 앱의 이름을 적으시오", text: $keyword)
          //                    .foregroundColor(.blue)
            .font(.system(size: 14, weight: .medium))
            .textFieldStyle(.plain)
          // textField를 선택하면 키보드가 나오고
            .focused($isFocused, equals: true)
          
          if !keyword.isEmpty {
            Button(action: { keyword = "" }) {
              Image(systemName: "xmark.circle.fill")
                .imageScale(.large)
                .frame(width: 15, height: 15)
                .foregroundColor(.gray)
            }
          }
        }
        //        .frame(maxHeight: 50)
        .frame(width: 280 ,height: 35)
        .padding(.horizontal, 16)
        .background(
          RoundedRectangle(cornerRadius: 8)
            .stroke(.black, lineWidth: 1)
            .background(
              RoundedRectangle(cornerRadius: 8)
                .fill(.gray.opacity(0.2)))
        )
        
        Spacer()
        
        Button(action: { keyword = "" }) {
          Text("취소")
            .font(.system(size: 18, weight: .medium))
        }
        
        Spacer()
      } // HStack
    } // VStack
    .padding(.top, 10)
    .padding(.horizontal, 5)
  }
  
  @ViewBuilder
  var content: some View {
    List {
      ForEach(items, id: \.self) { title in
        // list에 있는 cell을 눌렀을때 배경색이 바뀌지 않고 오른쪽에 있는 화살표가 안보이게 하기 위해 ZStack 이용
        ZStack {
          NavigationLink(destination: DetailView().navigationBarBackButtonHidden(true)) {
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
                .foregroundColor(.gray)
              
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
    // 다른곳을 탭하였을때가 아닌 드래그 하였을때 키보드가 내려가도록
    // => 드래그로 바꾼이유: 예를들어 검색을 했는데 화면을 꽉 채우게 검색 결과가 나오면 빈곳을 탭할곳이 없어서 원하지 않은 아이템을 선택할 수 있으므로
    // => 문제가 맨위를 드래그 해야 사라진다... -> 아래로 드래그 할때도 없어지게 하려면...?
    .scrollDismissesKeyboard(.interactively)
    .listStyle(.plain)
  }
  
  var body: some View {
    NavigationView {
      // => 기본으로 spacing이 4 들어가있음
      VStack(spacing: 20) {
        header
        content
      }
      .background(.black)
      // 탭 제스처를 사용하면 navigation를 통한 view 이동이 안됌
      //      .onTapGesture {
      //        isFocused = false
      //      }
      // 키워드가 비어있으면 모든 리스트, 키워드를 입력하면 필터링된 텍스트가 나오도록
      .onChange(of: keyword) {
        items = keyword.isEmpty ? mock2 : filter($0)
      }
    }
  }
}

let mock2: [String] = [
  "방탈출",
  "방탈출게임",
  "방치형",
  "방 구하기",
  "전국방탈출",
  "EndlessRooms",
  "HeartlessRoom",
  "Escape Rooms",
  "방탈출 : 탈출 게임",
  "탈출 게임",
  "방탈출 퍼즐 게임",
  "방탈출 스토리 게임",
  "방탈출 미스터리 게임",
]

struct DetailView {
  @State private var keyword = "방탈출"
  
  // textField를 선택하면 키보드가 나오게 하기 위해
  @FocusState private var isFocused
  @Environment(\.dismiss) var dismiss
}

extension DetailView: View {
  
  @ViewBuilder
  var header: some View {
    VStack(spacing: 10) {
      HStack {
        HStack {
          Image(systemName: "magnifyingglass")
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 15, height: 15)
            .foregroundColor(.gray)
          
          TextField("", text: $keyword)
            .font(.system(size: 14, weight: .medium))
            .textFieldStyle(.plain)
          // textField를 선택하면 키보드가 나오고
            .focused($isFocused, equals: true)
          
          if !keyword.isEmpty {
            Button(action: { dismiss() }) {
              Image(systemName: "xmark.circle.fill")
                .frame(width: 15, height: 15)
                .foregroundColor(.gray)
            }
          }
        }
        .frame(width: 280 ,height: 35)
        .padding(.horizontal, 16)
        .background(
          RoundedRectangle(cornerRadius: 8)
            .stroke(.black, lineWidth: 1)
            .background(
              RoundedRectangle(cornerRadius: 8)
                .fill(.gray.opacity(0.2)))
        )
        
        Spacer()
        
        Button(action: {  }) {
          Text("취소")
            .font(.system(size: 18, weight: .medium))
            .onTapGesture {
              keyword = ""
              dismiss()
            }
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
    } // VStack
    .padding(.top, 10)
    .padding(.bottom, 10)
    .padding(.horizontal, 10)
    .background(.gray.opacity(0.2))
  }
  
  @ViewBuilder
  var content: some View {
    List {
      ForEach(Post.MOCK_POSTS, id: \.self) { post in
        DetailCellView(post: post)
      }
      .listRowSeparator(.hidden)
      .listRowInsets(EdgeInsets())
    }
    .background(.black)
    .listStyle(.plain)
    .scrollDismissesKeyboard(.interactively)
  }
  
  var body: some View {
    VStack(spacing: .zero) {
      header
      content
    }
    .onTapGesture {
      isFocused = false
    }
  }
}

struct DetailCellView {
  let post: Post
  // 사이즈 정의:   |-|    ||     ||.    |-|
  // =>  |padding|  image  |spacing|  image  |spacing|  image  |padding|
  // => padding: 10, spacing: 10
  private let imageDimension: CGFloat = (UIScreen.main.bounds.width - 40) / 3
  private var imageHeight: CGFloat {
    imageDimension * 2
  }
}

extension DetailCellView: View {
  
  @ViewBuilder
  var content: some View {
    VStack {
      HStack {
        Image(post.thumbnail)
          .resizable()
          .scaledToFill()
          .frame(width: 60, height: 60)
          .cornerRadius(20)
        VStack(alignment: .leading, spacing: 5) {
          Text(post.title)
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(.white)
          Text(post.explantion)
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(.gray)
          HStack(spacing: 4) {
            ForEach(0 ..< 5, id: \.self) { star in
              Image(systemName: post.stars)
                .renderingMode(.template)
                .resizable()
                .scaledToFill()
                .frame(width: 10, height: 10)
            }
            Text(post.evaluation)
              .font(.system(size: 12, weight: .ultraLight))
          }
          .foregroundColor(.gray)
        }
        
        Spacer()
        
        VStack(spacing: 5) {
          Button {
            // => 버튼만 눌렀을대 실행이 되야 된는데 왜 모든 곳을 눌러도 실행이 되는건가??
            print("DEBUG: Did tap button..")
          } label: {
            Text("받기")
              .font(.system(size: 14, weight: .bold))
              .foregroundColor(.blue)
              .frame(width: 80, height: 30)
              .background(
                RoundedRectangle(cornerRadius: 20)
                  .fill(.gray.opacity(0.2))
              )
          }
          Text(post.pathOfPurchase)
            .font(.system(size: 10, weight: .light))
            .foregroundColor(.gray)
        }
        .padding(.top, 20)
      }
      
      Group {
        HStack(spacing: 10) {
          // => 인덱스가 짝수이면 하나의 이미지 설명, 홀수이면 3개의 이미지 설명이 나오도록 설정
          if let index = Post.MOCK_POSTS.firstIndex(of: post) {
            if index % 2 == 0 {
              Image(post.imageDescriptions)
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
                  .frame(width: imageDimension, height: imageHeight)
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
    .background(.black)
  }
  
  var body: some View {
    content
  }
}

struct Post: Hashable {
  let thumbnail: String
  let title: String
  let explantion: String
  let stars: String
  let evaluation: String
  //    let    버튼
  let pathOfPurchase: String
  let imageDescriptions: String
}

extension Post {
  
  static var MOCK_POSTS: [Post] = [
    .init(
      thumbnail: "image1",
      title: "방탈출 - Escape Rooms",
      explantion: "인기 방탈출 게임",
      stars: "star.fill",
      evaluation: "5.4천",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image2"
    ),
    .init(
      thumbnail: "image2",
      title: "탈출 게임 The Lake View",
      explantion: "당신은 여기서 탈출할 수 있습니까 ?",
      stars: "star.fill",
      evaluation: "622",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image3"
    ),
    .init(
      thumbnail: "image3",
      title: "노바디즈: 시체 처리반",
      explantion: "시체를 숨기로 흔적을 남기지 마십시오.",
      stars: "star.fill",
      evaluation: "1.8만",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image4"
    ),
    .init(
      thumbnail: "image4",
      title: "탈출 게임 Onsen",
      explantion: "어드벤처",
      stars: "star.fill",
      evaluation: "363",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image5"
    ),
    .init(
      thumbnail: "image5",
      title: "노바디즈: 사후세계",
      explantion: "시체를 숨기로 흔적을 남기지 마십시오.",
      stars: "star.fill",
      evaluation: "1.9천",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image6"
    ),
    .init(
      thumbnail: "image6",
      title: "방탈출: 탈출게임",
      explantion: "탈출 게임",
      stars: "star.fill",
      evaluation: "295",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image7"
    ),
    .init(
      thumbnail: "image7",
      title: "노바디즈: 사후세계",
      explantion: "시체를 숨기로 흔적을 남기지 마십시오.",
      stars: "star.fill",
      evaluation: "1.9천",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image8"
    ),
    .init(
      thumbnail: "image8",
      title: "노바디즈: 사후세계",
      explantion: "시체를 숨기로 흔적을 남기지 마십시오.",
      stars: "star.fill",
      evaluation: "1.9천",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image9"
    ),
    .init(
      thumbnail: "image9",
      title: "노바디즈: 사후세계",
      explantion: "시체를 숨기로 흔적을 남기지 마십시오.",
      stars: "star.fill",
      evaluation: "1.9천",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image10"
    ),
    .init(
      thumbnail: "image10",
      title: "노바디즈: 사후세계",
      explantion: "시체를 숨기로 흔적을 남기지 마십시오.",
      stars: "star.fill",
      evaluation: "1.9천",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image11"
    ),
    .init(
      thumbnail: "image11",
      title: "노바디즈: 사후세계",
      explantion: "시체를 숨기로 흔적을 남기지 마십시오.",
      stars: "star.fill",
      evaluation: "1.9천",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image12"
    ),
    .init(
      thumbnail: "image12",
      title: "노바디즈: 사후세계",
      explantion: "시체를 숨기로 흔적을 남기지 마십시오.",
      stars: "star.fill",
      evaluation: "1.9천",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image13"
    ),
    .init(
      thumbnail: "image13",
      title: "노바디즈: 사후세계",
      explantion: "시체를 숨기로 흔적을 남기지 마십시오.",
      stars: "star.fill",
      evaluation: "1.9천",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image14"
    ),
    .init(
      thumbnail: "image14",
      title: "노바디즈: 사후세계",
      explantion: "시체를 숨기로 흔적을 남기지 마십시오.",
      stars: "star.fill",
      evaluation: "1.9천",
      pathOfPurchase: "앱 내 구입",
      imageDescriptions: "image15"
    ),
    
  ]
}



// - 네비게이션 view안에서 드래그 하면 navigationBar위로 cell들이 올라갈때 searchBar의 배경이 흐릿하게 보여야 되는데 안보인다
//    => 일단 Header의 색을 바꿔서 네비게이션 안의 view인 것처럼 표현
// - 텍스트 필드 크기 조정, 취소 버튼 크기 조정
// - 다른곳을 탭하였을때가 아닌 드래그 하였을때 키보드가 내려가도록
//    => 드래그로 바꾼이유: 예를들어 검색을 했는데 화면을 꽉 채우게 검색 결과가 나오면 빈곳을 탭할곳이 없어서 원하지 않은 아이템을 선택할 수 있으므로
//    => 문제가 맨위를 드래그 해야 사라진다... -> 아래로 드래그 할때도 없어지게 하려면...?

// - 패딩을 주는데 자꾸 짤리길래 무언가 했는데 화면의 너비를 잘못 설정함
//    => 화면의 너비를 정의하고 사용할때는 아이템간의 spacing과 padding 모두 신경쓴다음 정의 해주어야 된다!
//    ex) 사이즈 정의:   |-|    ||     ||.    |-|
//      =>  |padding|  image  |spacing|  image  |spacing|  image  |padding|
//      => padding: 10, spacing: 10
//      private let imageDimension: CGFloat = (UIScreen.main.bounds.width - 40) / 3

