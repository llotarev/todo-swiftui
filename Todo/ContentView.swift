//
//  ContentView.swift
//  Todo
//
//  Created by Виктор Лотарев on 27.02.2021.
//

import SwiftUI
import Combine


struct ContentView: View {
    
    @ObservedObject var taskStore = TaskStore()
    @State var todoText : String = ""
    
    var searchBar : some View{
        
        HStack {
            TextField("Текст заметки...", text: self.$todoText)
                .frame( height: 48, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.horizontal, 12)
                .background(Color.white)
                .cornerRadius(48)
            
            Button(action: {
                self.add()
            }, label: {
                Text("Add")
                    .frame( height: 48, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal, 24)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(48)
            })
        }
    }
    
    var body: some View {
        ZStack{
            
            Color.black.ignoresSafeArea(.all)
            
            NavigationView{
                VStack{
                    List{
                        ForEach(self.taskStore.task){ task in
                            Text(task.text)
                        }
                        .onMove(perform: self.move)
                        .onDelete(perform: self.delete)
                    }
                    searchBar.padding()
                }
                .navigationBarTitle("Заметки")
                .navigationBarItems(trailing: EditButton())
            }
            
        }
    }
    
    
    func add() {
        if self.todoText != "" {
            taskStore.task.append(
                Task(
                    id:taskStore.task.count + 1,
                    text:self.todoText
                ))
            self.todoText = ""
        }else{}
    }
    
    func move(from fromIndex: IndexSet, to toIndex: Int){
        taskStore.task.move(
            fromOffsets: fromIndex,
            toOffset:toIndex
        )
    }
    
    func delete(at index: IndexSet) -> Void {
        taskStore.task.remove(atOffsets: index)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
