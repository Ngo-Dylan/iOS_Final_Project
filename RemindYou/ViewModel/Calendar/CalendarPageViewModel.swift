//
//  CalendarPageViewModel.swift
//  RemindYou
//
//  Created by Dylan Ngo on 12/4/22.
//

import Foundation
import SwiftUI
import UIKit

struct CalendarPageViewModel: UIViewControllerRepresentable {
    var controllers: [UIViewController]
    
    @ObservedObject var pageManager : PageManager
    
    var currentPage: Int {
        return pageManager.currentPage
    }
    
    var direction : UIPageViewController.NavigationDirection {
        return pageManager.direction
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let calendarPageViewModel = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        calendarPageViewModel.delegate = context.coordinator
        return calendarPageViewModel
    }
    
    func updateUIViewController(_ calendarPageViewModel: UIPageViewController, context: Context) {
        let coor = context.coordinator
        if coor.last == currentPage {
            return
        }
        calendarPageViewModel.setViewControllers([self.controllers[0]], direction: direction, animated: true)
        coor.last = currentPage
    }
    
    class Coordinator: NSObject, UIPageViewControllerDelegate {
        var parent: CalendarPageViewModel
        var last : Int = NSNotFound
        
        init(_ calendarPageViewModel: CalendarPageViewModel) {
            self.parent = calendarPageViewModel
        }
    }
}
