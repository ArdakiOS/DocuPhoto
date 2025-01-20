//
//  DocuPhotoApp.swift
//  DocuPhoto
//
//  Created by admin on 12/25/24.
//

import SwiftUI
import ApphudSDK

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        Apphud.start(apiKey: "app_1aXkBUZyoEypmxGHWdyhgbFuBJ3gmj") // TEST ONLY
        return true
    }
}

@main
struct DocuPhotoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var subscriptionsManager = ApphudSubsManager()
    var body: some Scene {
        WindowGroup {
            ZStack {
                if subscriptionsManager.didOnb {
                    MainView()
                        .preventScreenshot()
                        
                } else {
                    OnboardingView()
                }
            }
            .environmentObject(subscriptionsManager)
            .overlay(content: {
                if subscriptionsManager.isLoading {
                    LoadingView()
                        .opacity(subscriptionsManager.isLoading ? 1.0 : 0.0)
                }
            })
            .animation(.easeInOut(duration: 0.5), value: subscriptionsManager.isLoading)
            .animation(.easeInOut(duration: 0.5), value: subscriptionsManager.didOnb)
            .ignoresSafeArea()
            .preferredColorScheme(.light)
            
        }
    }
}
