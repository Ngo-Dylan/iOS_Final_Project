//
//  Todo_TaskDetailView.swift
//  RemindYou
//
//  Created by Dylan Ngo on 12/3/22.
//

import SwiftUI

struct TaskDetailsHeader:View {
    
    @State var taskDetails:TaskList!
    
    var body: some View{
        VStack(alignment:.center){
            Text(taskDetails.categoryName)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Text("\(taskDetails.noOfTasks) tasks")
                .foregroundColor(.black.opacity(0.5))
                .font(.callout)
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

struct TaskDetailsCell:View {
    
    @ObservedObject var viewModel: LandingViewModel
    @State var task:Task!
    
    var body: some View{
        HStack{
            VStack(alignment:.leading){
                Text(task.taskNote ?? "")
                    .font(.callout)
                    .foregroundColor(task.taskCompleted ? .blue : .black)
                    .strikethrough(task.taskCompleted ? true : false, color: .blue)
                Spacer()
                Text(getDateFormatString(date: task.taskDate ?? Date()))
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(task.taskCompleted ? .blue : .black)
                    .strikethrough(task.taskCompleted ? true : false, color: .blue)
                Spacer()
                Text(task.taskName ?? "")
                    .font(.caption2)
                    .foregroundColor(task.taskCompleted ? .blue : .black)
                    .strikethrough(task.taskCompleted ? true : false, color: .blue)
            }
            Spacer()

            Button(action: {
                let taskObj = task
                taskObj?.taskCompleted.toggle()
                CoreDataManager.shared.save()
                viewModel.taskList = viewModel.getAllTaskList()
                
            }){
                Image(task.taskCompleted ? "checkbox_fill"  : "checkbox")
                    .resizable()
                    .foregroundColor(task.taskCompleted ? .blue :.gray)
                    .frame(width: 25, height: 25)
            }
        }
        .padding()
    }
    func getDateFormatString(date:Date) -> String {
        var dateString = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM-dd-yyyy, h:mm a"
        
        dateString = dateFormatter.string(from: date)
        return dateString
    }

}

struct Todo_TaskDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: LandingViewModel
    @State var taskDetails:TaskList!

    var body: some View {
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
            VStack(alignment:.leading){
                TaskDetailsHeader(taskDetails: taskDetails)
                List{
                    ForEach(taskDetails.taskList) { task in
                        TaskDetailsCell(viewModel: viewModel, task: task)
                    }
                }
                .padding(.bottom, 1)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            
            HStack{
                Image(systemName: "chevron.backward")
                Circle()
                    .strokeBorder(Color.gray,lineWidth: 1)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                    .overlay(
                        taskDetails.categoryImage
                            .resizable()
                            .frame(width: 28, height: 28)
                    )
                    .padding(.leading, UIScreen.main.bounds.width/2 - 60)
            }
        }))
    }
}

struct Todo_TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Todo_TaskDetailView(viewModel: .init())
    }
}
