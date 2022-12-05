//
//  PageManager.swift
//  RemindYou
//
//  Created by Dylan Ngo on 12/4/22.
//

import Foundation
import UIKit

class PageManager : ObservableObject {
    
    @Published var currentPage : Int = 0 {
        willSet {
            if newValue >= currentPage {
                direction = .forward
            } else {
                direction = .reverse
            }
            objectWillChange.send()
        }
        
        didSet {
            onPageChange?(currentPage,direction)
        }
    }
    
    var direction : UIPageViewController.NavigationDirection = .forward
    
    var onPageChange: ((Int,UIPageViewController.NavigationDirection)->Void)?
}
