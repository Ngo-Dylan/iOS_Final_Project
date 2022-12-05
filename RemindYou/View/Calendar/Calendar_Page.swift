//
//  Calendar_Page.swift
//  RemindYou
//
//  Created by Dylan Ngo on 12/4/22.
//

import SwiftUI

struct Calendar_Page<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    @ObservedObject var pageManager : PageManager
    
    init(pageManager : PageManager,views: [Page]) {
        self.pageManager = pageManager
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
    }

    var body: some View {
        CalendarPageViewModel(controllers: viewControllers, pageManager: pageManager)
    }
}

struct Calendar_Page_Previews: PreviewProvider {
    static var previews: some View {
        Calendar_Page(pageManager: PageManager(), views: [Color.blue])
            .aspectRatio(3/2, contentMode: .fit)
    }
}
