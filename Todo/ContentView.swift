//
//  ContentView.swift
//  Todo
//
//  Created by Виктор Лотарев on 27.02.2021.
//

import SwiftUI


struct ContentView: View {
    
    @State var posts : [Post] = [
        Post(
            id: 1,
            title: "Title",
            body: "Lorem inpsum..."
        )
    ]
    
    var body: some View {
        NavigationView() {
            ScrollView{
                PostListView(posts: posts)
            }
            .onAppear(){
                API().getPost { (posts) in
                    self.posts = posts
                }
            }
            .navigationBarItems(
                leading: Text("Posts"),
                trailing: Image(systemName: "network").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            )
        }
    }
}


struct Post: Codable, Identifiable {
    var id:Int
    var title: String
    var body: String
}

class API {
    
    //    метод в который мы передаем callback/closure
    func getPost(complition: @escaping ([Post]) -> ()) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            let posts = try! JSONDecoder().decode([Post].self , from: data!)
            
            DispatchQueue.main.async {
                //                декодируем данные и после прокидываем их в параметры
                //                нашего callback/closure
                complition(posts)
            }
        }
        .resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TextView: View {
    
    var text: String
    
    var body: some View {
        HStack{
            Text(text)
                .foregroundColor(Color.white)
            Spacer()
        }
    }
}

struct PostListView: View {
    
    @State var viewAll: Bool = false
    var posts: [Post] = []
    
    var body: some View {
        ForEach(posts){ post in
            VStack(alignment: .leading, spacing: 4){
                TextView(text: post.title)
                    .font(.headline)
                TextView(text: post.body)
                    .lineLimit( viewAll  ? nil : 2)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .cornerRadius(16)
            .shadow(color: Color.blue.opacity(0.4), radius: 12, x: 0, y: 12)
            .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
        }
        .padding()
        .onTapGesture {
            self.viewAll.toggle()
        }
    }
}
