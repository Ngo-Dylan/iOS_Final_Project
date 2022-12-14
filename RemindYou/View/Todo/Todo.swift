//
//  Todo.swift
//  RemindYou
//
//  Created by Dylan Ngo on 11/29/22.
//

import SwiftUI

struct TaskCellView:View {
    
    @State var taskImg:Image
    @State var categoryName: String
    @State var noOftask: Int
    
    var body: some View{
        HStack{
            VStack(alignment: .leading){
                taskImg
                    .resizable()
                    .frame(width: 30, height: 30)
                Spacer()
                    .frame(height: 20)
                VStack(alignment: .leading){
                    Text(categoryName)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                    Text("\(noOftask) Tasks")
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
        .frame(width: 140, height: 140)
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(15)
    }
}

struct TaskEmptySateView: View {
    var body: some View{
        VStack{
            Image("task_empty")
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
        }
        .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.width - 60)
    }
}

struct Todo: View {
    init() {
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    @StateObject var viewModel: LandingViewModel = LandingViewModel()
    @State var isPresentCreateTask:Bool = false
    
    var body: some View {
        NavigationView{
            ZStack {
                if viewModel.taskList.count == 0{
                    Color.white.edgesIgnoringSafeArea(.all)
                }
                else{
                    Color.black.opacity(0.05).edgesIgnoringSafeArea(.all)
                }
                ScrollView{
                    VStack{
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150, maximum: 200), spacing: 20)], content: {
                            ForEach(viewModel.taskList, id: \.categoryId){ task in
                                NavigationLink(
                                    destination: Todo_TaskDetailView(viewModel: viewModel, taskDetails: task)) {
                                    if task.isShow{
                                        TaskCellView(taskImg: task.categoryImage, categoryName: task.categoryName, noOftask: task.noOfTasks)
                                    }
                                }
                            }
                        })
                        Spacer()
                    }
                    .padding()
                }
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button(action: {
                            isPresentCreateTask = true
                        }){
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding()
                        }
                        Spacer()
                    }
                }
                if viewModel.taskList.count == 0{
                    TaskEmptySateView()
                }
            }
            .navigationTitle("To-Do")
        }
        .fullScreenCover(isPresented: $isPresentCreateTask, content: {
            withAnimation {
                Todo_NewTask(viewModel: viewModel, isPresentCreateTask: $isPresentCreateTask)
            }
        })
        .onAppear{
            viewModel.taskList = viewModel.getAllTaskList()
        }
        
    }
}

struct Todo_Previews: PreviewProvider {
    static var previews: some View {
        Todo()
    }
}
