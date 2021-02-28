//
//  TaskFile.swift
//  Todo
//
//  Created by Виктор Лотарев on 27.02.2021.
//

import Foundation
import SwiftUI
import Combine

struct Task : Identifiable {
    var id = Int()
    var text = String()
}

class TaskStore : ObservableObject {
    @Published var task = [Task]()
}

