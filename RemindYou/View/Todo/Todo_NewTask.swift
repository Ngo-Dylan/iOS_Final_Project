//
//  Todo_NewTask.swift
//  RemindYou
//
//  Created by Dylan Ngo on 11/30/22.
//

import SwiftUI

// New Task Header View
struct NewTaskHeaderView: View {
    @Binding var isPresentCreateTask: Bool
    var body: some View{
        HStack{
            Spacer()
            Text("New Task")
                .font(.title2)
                .fontWeight(.medium)
                .padding(.leading, 50)
            Spacer()
            Button(action: {
                isPresentCreateTask = false
            }){
                Image(systemName: "xmark")
            }
            .padding(.trailing,30)
        }
    }
}

// New Task TextEditor View
struct NewTaskEditorView: View{
    
    @Binding var txtTask:String
    
    var body: some View{
        VStack(alignment:.leading){
            Text("What are you planning?")
                .foregroundColor(.gray)
                .frame(height: 10, alignment: .leading)
            
            TextEditor(text: $txtTask)
                .frame( height: 150, alignment: .leading)
            
            Divider()
            
            Spacer()
                .frame(height: 30)
        }
    }
}

struct NewTaskBottomView: View{
    
    @Binding var selectedDate:Date
    @Binding var notes:String
    @Binding var categoryName:String
    @Binding var categoryId:Int
    
    var body: some View{
        
        VStack(spacing:12){
            
            //Date
            HStack{
                Image(systemName: "bell.badge")
                    .foregroundColor(.gray)
                    .frame(width: 30, height: 30, alignment: .leading)
                VStack{
                    DatePicker("Select Date", selection: $selectedDate)
                        .labelsHidden()
                }
                Spacer()
            }
            
            //Add title
            HStack{
                Image(systemName: "square.and.pencil")
                    .foregroundColor(.gray)
                    .frame(width: 30, height: 30, alignment: .leading)
                VStack{
                    TextEditor(text: $notes)
                        .foregroundColor(notes == "Add title" ? .gray : .black)
                        .frame(height: 40)
                        .onTapGesture {
                            if notes == "Add title"{
                                notes = ""
                            }
                        }
                }
            }
            
            HStack{
                Image(systemName: "tag")
                    .foregroundColor(.gray)
                    .frame(width: 30, height: 30, alignment: .leading)
                VStack{
                    Text(categoryName)
                        .foregroundColor(categoryName == " Select Category" ? .gray : .black)
                }
                Spacer()
            }
            
            CategoryView(categoryName: $categoryName, categoryId: $categoryId)
        }
    }
}

// New Task Category Selection View
struct CategoryView: View{
    
    @Binding var categoryName:String
    @Binding var categoryId:Int
    
    var categoryList: [Categories] = getCategoryList()
    
    var body: some View{
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 150), spacing: 10)], content: {
                
                ForEach(categoryList){ cat in
                    if (cat.categoryName != "All")
                    {
                        HStack{
                            Image(cat.categoryImage)
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text(cat.categoryName)
                                .font(.callout)
                                .fontWeight(.regular)
                            Spacer()
                        }
                        .onTapGesture {
                            categoryName = cat.categoryName
                            categoryId = cat.id
                        }
                        .frame(width: 120, height: 30)
                    }
                    
                }
            })
        }
    }
}

extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}


struct Todo_NewTask: View {
    
    @ObservedObject var viewModel: LandingViewModel
    
    @Binding var isPresentCreateTask: Bool
    @State var txtTask:String = ""
    @State var selectedDate:Date = Date()
    @State var notes:String = "Add title"
    @State var categoryName:String = " Select Category"
    @State var categoryId:Int = 0
    
    //Alert
    @State var isShowAlert: Bool = false
    @State var alertTitle: String = ""
    @State var alertSubTitle: String = ""
    @State var cancelTitle: String = ""
    
    var body: some View {
        ScrollView{
            VStack{
                Spacer()
                    .frame(height: 30)
                
                NewTaskHeaderView(isPresentCreateTask: $isPresentCreateTask)
                
                Spacer()
                VStack(alignment:.leading){
                    
                    NewTaskEditorView(txtTask: $txtTask)
                    
                    NewTaskBottomView(selectedDate: $selectedDate, notes: $notes, categoryName: $categoryName, categoryId: $categoryId)
                    
                    Spacer()
                }
                .padding()
                
                Button(action: {
                    if txtTask == ""{
                        alertTitle = "Oops"
                        alertSubTitle = "Please enter Task Description"
                        isShowAlert = true
                    }
                    else if categoryName == " Select Category"{
                        alertTitle = "Oops"
                        alertSubTitle = "Please select Category"
                        isShowAlert = true
                    }
                    else{
                        let task = Task(context: CoreDataManager.shared.viewContext)
                        task.taskCategoryID = Int32(categoryId)
                        task.taskCategoryName = categoryName
                        task.taskDate = selectedDate
                        task.taskCompleted = false
                        task.taskName = txtTask
                        task.taskNote = notes == "Add title" ? "" : notes
                        CoreDataManager.shared.save()
                        viewModel.taskList = viewModel.getAllTaskList()
                        isPresentCreateTask = false
                    }
                    
                }){
                    Text("Add")
                        .frame(width: UIScreen.main.bounds.width - 30, height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .onTapGesture {
            endTextEditing()
        }
        .alert(isPresented: $isShowAlert, content: {
            Alert(title: Text(alertTitle), message: Text(alertSubTitle), dismissButton: .default(Text("Ok")))
        })
    }
}

struct Todo_NewTask_Previews: PreviewProvider {
    static var previews: some View {
        Todo_NewTask(viewModel: .init(), isPresentCreateTask: .constant(false))
    }
}
