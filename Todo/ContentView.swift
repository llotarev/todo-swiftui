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
    
    func addTodo(todo: String) -> Void {
        if self.todoText != "" {
            taskStore.task.append(
                Task(
                    id: taskStore.task.count + 1,
                    text: todoText
                ))
            self.todoText = ""
        }else{
      
        }
    }
    
    var searchBar : some View{
        HStack {
        TextField(
            "Текст заметки...",
            text:self.$todoText
        )
                Button( action: {
                    self.addTodo(todo: self.todoText)
                }, label: {
                    Text("Добавить")
            })
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                searchBar.padding()
                List{
                    ForEach(self.taskStore.task){ task in
                    Text(task.text)
                    }
                    .onMove(perform: self.move)
                    .onDelete(perform: self.delete)
                }
            }
            .navigationBarTitle("Заметки")
            .navigationBarItems(trailing: EditButton())
        }
    }
    
    
    func move(from fromIndex: IndexSet, to toIndex: Int) ->Void{
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
