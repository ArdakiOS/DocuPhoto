import SwiftUI
import ApphudSDK
import StoreKit

enum ApphudPaywallIds : String {
    case onb = "onb_paywall"
    case settings = "settings_paywall"
    case inapp = "inapp_paywall"
}

struct AppHudProductSkProduct : Hashable{
    let skProduct : Product
    let appHudProduct : ApphudProduct
}

@MainActor
class ApphudSubsManager : ObservableObject {
    
    @Published var alertTitle: String?
    @Published var alertMessage: String?
    @Published var alertIsPresented: Bool = false
    @Published var currentActivePayWall : ApphudPaywall?
    
    @Published var selectedProduct: ApphudProduct?
    @Published var highlightedProdcut : Product?
    @Published var isLoading: Bool = true
    
    @Published var products : [AppHudProductSkProduct] = []
    @Published var apphudProducts : [ApphudProduct] = [] {
        didSet{
            Task{
                await convertAppHudProductToSkProducts()
            }
        }
    }
    
    @Published var hasSubscription = false
    @AppStorage("didOnb") var didOnb = false
    
    init() {
        hasSubscription = Apphud.hasActiveSubscription()
        print("hasSubscription \(hasSubscription)")
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            self.isLoading = false
        }
    }
    
    @MainActor
    func getPayWallProducts(id : String) {
        products = []
        Apphud.paywallsDidLoadCallback { paywalls, _  in
            // if paywalls are already loaded, callback will be invoked immediately
            if let paywall = paywalls.first(where: { $0.identifier == id }) {
                self.apphudProducts = paywall.products
                Apphud.paywallShown(paywall)
                self.currentActivePayWall = paywall
                // setup your UI with these products
            }
        }
    }
    
    func dismissPayWall() {
        if let paywall = currentActivePayWall {
            Apphud.paywallClosed(paywall)
        }
    }
    
    @MainActor
    func convertAppHudProductToSkProducts() async {
        for i in apphudProducts {
            if let skProd = try? await i.product() {
                let newEntry = AppHudProductSkProduct(skProduct: skProd, appHudProduct: i)
                self.products.append(newEntry)
            }
        }
        self.products.sorted(by: {$0.skProduct.displayPrice < $1.skProduct.displayPrice})
    }
    
    @MainActor
    func makePruchase() {
        guard let product = selectedProduct else {return}
        Apphud.purchase(product) { result in
           if let subscription = result.subscription, subscription.isActive(){
               self.hasSubscription = true
           } else {
               self.alertTitle = "Something went wrong. Please try again later"
               self.alertMessage = "Error making purchase"
               self.alertIsPresented = true
           }
        }
    }
    
    @MainActor
    func restorePurchase() {
        Apphud.restorePurchases{ subscriptions, purchases, error in
           if Apphud.hasActiveSubscription(){
               self.alertTitle = "Subscription found"
               self.alertMessage = "Subscription restored, you may continue"
               self.alertIsPresented = true
               self.hasSubscription = true
           } else {
               self.alertTitle = "No active subscription found"
               self.alertMessage = "There is no currently active subscriptions, please subscribe to continue"
               self.alertIsPresented = true
           }
        }
    }
}
