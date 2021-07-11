//
//  AppTabView.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 17/06/2021.
//

import SwiftUI

struct TabContainerView: View {
    
    @StateObject var viewModel = TabContainerViewModel()
    @EnvironmentObject var appInfo: AppInformation
    @State var title = ""
    @State var navBarHidden = false

    
    var body: some View {
        ZStack{
            TabView(selection: $appInfo.selectedTab) {
//                if !appInfo.showPlanTab {
//                    ForEach(viewModel.tabItemsNoProjects, id: \.self) { item in
//                        tabView(tabItemType: item.type)
//                            .tabItem {
//                                Image(systemName: item.imageName)
//                                Text(item.title)
//                            }.tag(item.type)
//                    }
//
//                } else if appInfo.showPlanTab {
                
                    ForEach(viewModel.tabItems, id: \.self) { item in
                        tabView(tabItemType: item.type)
                            .tabItem {
                                Image(systemName: item.imageName)
                                Text(item.title)
                            }.tag(item.type)
                    }
                    
 //               }
                
            }
          
            
                
            
        }
        
       
        .accentColor(Color("blue"))
        

        //.navigationBarTitle(title)
//        .onChange(of: tabContainerViewModel.selectedTab) { newValue in
//            switch newValue {
//            case .home: self.navBarHidden = true
//            case .account: self.title = "Account"
//                self.navBarHidden = false
//            case .projects:
//                //self.title = "Projects"
//                self.navBarHidden = false
//            }
//        }

     //   .navigationBarHidden(navBarHidden)
            
    }
    
    @ViewBuilder
    func tabView(tabItemType: AppInformation.TabItem.TabItemType) -> some View {
        switch tabItemType {
        case .plan:
            NavigationView{
            HomeScreenView()
            }
            .animation(.easeInOut)
            .transition(.slide) 
        case .account:
            NavigationView{
            AccountView()
            }
            
        case .projects:
            NavigationView{
            ProjectListView()
            }

        }
    }
}

struct TabContainerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            TabContainerView()
        }
    }
}
