//
//  TaskListView.swift
//  MVVM-ETPS4
//
//  Created by CATALINA MAC  on 5/15/24.
//

import SwiftUI

struct TaskListView: View {
    @StateObject private var taskViewModel = TaskViewModel()
    @State private var newTaskTitle = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(taskViewModel.tasks.indices, id: \.self) { index in
                        TaskRowView(task: $taskViewModel.tasks[index])
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            taskViewModel.tasks.remove(at: index)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle()) // Estilo de lista mejorado
                .navigationTitle("Lista de tareas")
                .padding()
                
                HStack {
                    TextField("Nueva tarea", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: {
                        // Agregar tarea solo si el campo de texto no está en blanco
                        if !newTaskTitle.isEmpty {
                            taskViewModel.addTask(title: newTaskTitle)
                            // Limpiar campo de entrada
                            newTaskTitle = ""
                        }
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                    .padding()
                }
                .background(Color(UIColor.systemGray6)) // Fondo mejorado
                .edgesIgnoringSafeArea(.bottom) // Ignorar el área segura para el fondo
            }
            .background(Color.black) // Cambiar color de fondo del body
            //.foregroundColor(.white) // Cambiar color de texto del body
        }
    }
}

struct TaskRowView: View {
    @Binding var task: Task
    
    var body: some View {
        HStack {
            Text(task.title)
                .foregroundColor(task.completed ? .gray : .primary)
            Spacer()
            Image(systemName: task.completed ? "checkmark.square.fill" : "square")
                .foregroundColor(task.completed ? .blue : .gray)
                .onTapGesture {
                    task.completed.toggle()
                }
        }
        .padding(.vertical, 8)
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
