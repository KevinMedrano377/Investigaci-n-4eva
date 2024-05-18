//
//  TaskViewModel.swift
//  MVVM-ETPS4
//
//  Created by CATALINA MAC  on 5/15/24.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    
    init() {
        self.loadTasks()
    }
    
    func toggleTaskCompleted(at index: Int) {
        tasks[index].completed.toggle()
        saveTasks()
    }
    
    func addTask(title: String) {
        tasks.append(Task(title: title, completed: false))
        saveTasks()
    }
    
    func loadTasks() {
        if let data = UserDefaults.standard.data(forKey: "tasks") {
            if let decodedTasks = try? JSONDecoder().decode([Task].self, from: data) {
                self.tasks = decodedTasks
                return
            }
        }
        // Si no hay tareas guardadas en UserDefaults, no se hace nada
    }
    
    func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: "tasks")
        }
    }
}
