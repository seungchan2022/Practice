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
                            .fill(.gray))
            )
        }
        .padding()
//        .background(.blue)
    }
    
    @ViewBuilder
    var content: some View {
        List {
            ForEach(items, id: \.self) { title in
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
                .listRowInsets(EdgeInsets())
                .padding(.horizontal, 16)
            }
        }
        .listStyle(.plain)
    }
    
    var body: some View {
        // => 기본으로 spacing이 4 들어가 있음
        VStack(spacing: 10) {
            header
            content
            //            DetailView()
        }
    
//        .background(.white)
        .onAppear {
            print("DEBUG: \(items)")
        }
        // 다른곳을 선택하면 키보드가 내려간다
        .onTapGesture {
            isFocused = false
        }
        // 키워드가 비어있으면 모든 리스트, 키워드를 입력하면 필터링된 텍스트가 나오도록
        .onChange(of: keyword) {
            items = keyword.isEmpty ? mock2 : filter($0)
        }
    }
}

let mock2: [String] = [
    "방탈출",
    "방탈출게임",
    "방탈출카페",
    "전국 방탈출",
    "방탈출 - escape rooms",
    "방탈출 - 2018",
    "방탈출 - 숨겨진 방의 비밀: 부역자",
    "방탈출 - 산타할아버지 집에서 탈출",
    "방탈출 - 발렌타인",
    "방탈출 - 비행기에서 탈출 게임"
]


struct DetailView {
    //    let title: String
}

extension DetailView: View {
    
    @ViewBuilder
    var detail: some View {
        List {
            ForEach(0 ..< 49) { post in
                DetailCellView()
            }
            
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
//            .padding()
        }
        .listStyle(.plain)
    }
    
    var body: some View {
        detail
    }
}

struct DetailCellView {
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width - 40) / 3
    private var imageHeight: CGFloat {
        imageDimension * 2
    }
}

extension DetailCellView: View {
    
    @ViewBuilder
    var detailCell: some View {
        VStack {
            HStack {
                Image("image")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .cornerRadius(20)
                VStack(alignment: .leading, spacing: 5) {
                    Text("방탈출 - Escape Rooms")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                    Text("인기 방탈출 게임.")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                    HStack(spacing: 4) {
                        ForEach(0 ..< 5) { star in
                            Image(systemName: "star.fill")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 10, height: 10)
                        }
                        Text("5.4천")
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
                    Text("앱 내 구입")
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(.gray)
                }
            }
            
            HStack(spacing: 10) {
                    Image("image3")
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageDimension, height: imageHeight)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    Image("image3")
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageDimension, height: imageHeight)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                
                    Image("image3")
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageDimension, height: imageHeight)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 20)
        .background(.black)
    }
    
    var body: some View {
        detailCell
    }
    
}
