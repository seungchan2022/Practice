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
                Image(systemName: "magnifyingglass")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                
                TextField("검색하실 앱의 이름을 적으시오", text: $keyword)
//                    .foregroundColor(.blue)
                    .textFieldStyle(.plain)
                // textField를 선택하면 키보드가 나오고
                    .focused($isFocused, equals: true)
                
                if !keyword.isEmpty {
                    Button(action: { keyword = "" }) {
                        Text("취소")
                    }
                }
            }
            .frame(maxHeight: 50)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.black, lineWidth: 1)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.gray.opacity(0.2)))
            )
        }
        .padding()
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
                            
                            Text(title)
                        }
                        Divider().background(Color.white)
                    }
                }
                .listRowInsets(EdgeInsets())
                .padding(.horizontal, 16)
                .listRowBackground(Color.clear)
            }
        }
        // 다른곳을 탭하였을때가 아닌 드래그 하였을때 키보드가 내려가도록
        .scrollDismissesKeyboard(.interactively)
        .listStyle(.plain)
    }
    
    var body: some View {
        NavigationView {
            // => 기본으로 spacing이 4 들어가있음
            VStack(spacing: 10) {
                header
                content
            }
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
    //    "방탈출카페",
    //    "전국 방탈출",
    //    "방탈출 - escape rooms",
    //    "방탈출 - 2018",
    //    "방탈출 - 숨겨진 방의 비밀: 부역자",
    //    "방탈출 - 산타할아버지 집에서 탈출",
    //    "방탈출 - 발렌타인",
    //    "방탈출 - 비행기에서 탈출 게임"
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
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                
                TextField("", text: $keyword)
                    .textFieldStyle(.plain)
                // textField를 선택하면 키보드가 나오고
                    .focused($isFocused, equals: true)
                
                if !keyword.isEmpty {
                    Button(action: { dismiss() }) {
                        Text("취소")
                    }
                }
            }
            .frame(maxHeight: 50)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.black, lineWidth: 1)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.gray.opacity(0.2)))
            )
        }
        .padding()
    }
    
    @ViewBuilder
    var detail: some View {
        List {
            ForEach(Post.MOCK_POSTS, id: \.self) { post in
                DetailCellView(post: post)
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
        }
        .listStyle(.plain)
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            header
            detail
        }
    }
}

struct DetailCellView {
    let post: Post
    
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
                    .frame(width: 80, height: 80)
                    .cornerRadius(20)
                VStack(alignment: .leading, spacing: 5) {
                    Text(post.title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                    Text(post.explantion)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                    HStack(spacing: 4) {
                        ForEach(0 ..< 5) { star in
                            Image(systemName: post.stars)
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 10, height: 10)
                        }
                        Text(post.evaluation)
                            .font(.system(size: 12, weight: .light))
                    }
                    .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(spacing: 5) {
                    Button {
                        print("DEBUG: Did tap button..")
                    } label: {
                        Text("받기")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.blue)
                            .frame(width: 80, height: 40)
                            .background(.black.opacity(0.5))
                            .cornerRadius(20)
                    }
                    Text(post.pathOfPurchase)
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(.gray)
                }
            }
            
            HStack(spacing: 20) {
                ForEach(0 ..< 3) { index in
                    Image(post.imageDescriptions)
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageDimension, height: imageHeight)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
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
        .init(thumbnail: "image", title: "방탈출 - Escape Rooms", explantion: "인기 방탈출 게임", stars: "star.fill", evaluation: "5.4천", pathOfPurchase: "앱 내 구입", imageDescriptions: "image2"),
        .init(thumbnail: "image2", title: "방탈출 - Escape Rooms", explantion: "인기 방탈출 게임", stars: "star.fill", evaluation: "5.4천", pathOfPurchase: "앱 내 구입", imageDescriptions: "image3"),
        .init(thumbnail: "image3", title: "방탈출 - Escape Rooms", explantion: "인기 방탈출 게임", stars: "star.fill", evaluation: "5.4천", pathOfPurchase: "앱 내 구입", imageDescriptions: "image4"),
    ]
}


