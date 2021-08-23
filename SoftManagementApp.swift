//
//  SoftManagementApp.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 18/05/2021.
//

import SwiftUI
import Firebase

@main
struct SoftManagementApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {

            let authentication = Authentication()
            let appInfo = AppInformation()
            
            LogInView()
                .environmentObject(authentication)
                .environmentObject(appInfo)
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
  
        }
    }
}

extension UIApplication {
    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true // set to `false` if you don't want to detect tap during other gestures
    }
}

