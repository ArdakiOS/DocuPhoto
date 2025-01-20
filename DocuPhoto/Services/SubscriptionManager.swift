//
//  SubscriptionManager.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 24.12.2024.
//

import Foundation
import StoreKit

@MainActor
class SubscriptionManager: ObservableObject {
    @Published var products: [Product] = []
    @Published var purchasedProductIDs: Set<String> = []
    @Published var selectedProduct: Product?
    
    @Published var isSubscribed: Bool = false
    @Published var isLoading: Bool = true
    
    @Published var alertTitle: String?
    @Published var alertMessage: String?
    @Published var alertIsPresented: Bool = false
    
    
    init() {
        Task {
            await retrieveProducts()
            await updateSubscriptionStatus()
            await listenForTransactionUpdates()
            
        }
        
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            self.isLoading = false
        }
    }
    
    func retrieveProducts() async {
        do {
            let productIDs = ["Week", "Month", "Year"]
            products = try await Product.products(for: productIDs)
            products = products.sorted(by: { $0.price < $1.price })
            selectedProduct = products.last
        } catch {
            print("Failed to fetch products: \(error)")
        }
    }
    
    private func updateSubscriptionStatus() async {
        var newStatus = false
        
        for product in products {
            do {
                if let statuses = try await product.subscription?.status {
                    for status in statuses {
                        switch status.state {
                        case .subscribed:
                            newStatus = true
                        case .expired, .revoked, .inGracePeriod, .inBillingRetryPeriod:
                            continue
                        default:
                            continue
                        }
                    }
                }
            } catch {
                print("Failed to fetch subscription status for product \(product.id): \(error)")
            }
        }
        
        DispatchQueue.main.async {
            self.isSubscribed = newStatus
        }
    }
    
    func purchase(_ product: Product) async {
        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verification):
                switch verification {
                case .verified:
                    await updateSubscriptionStatus()
                case .unverified:
                    print("Purchase unverified")
                }
            case .userCancelled:
                print("Purchase cancelled")
            case .pending:
                print("Purchase pending")
            @unknown default:
                print("Failed to purchase the product!")
                break
            }
        } catch {
            print("Purchase failed: \(error)")
        }
    }
    
    
    func listenForTransactionUpdates() async {
        for await update in Transaction.updates {
            switch update {
            case .verified(let transaction):
                purchasedProductIDs.insert(transaction.productID)
                print("Transaction verified for product ID: \(transaction.productID)")
                await transaction.finish()
            case .unverified(let transaction, _):
                print("Unverified transaction for product ID: \(transaction.productID)")
                await transaction.finish()
            }
        }
    }
    
    @MainActor
    func restorePurchases() async {
        var foundTransactions = false
        
        for await transaction in Transaction.currentEntitlements {
            foundTransactions = true
            switch transaction {
            case .verified(let verifiedTransaction):
                purchasedProductIDs.insert(verifiedTransaction.productID)
                print("Restored purchase for product ID: \(verifiedTransaction.productID)")
                
                alertTitle = "Purchases restored!"
                alertMessage = "Restored purchase for product ID: \(verifiedTransaction.productID)"
            case .unverified(let unverifiedTransaction, _):
                print("Unverified restored transaction for product ID: \(unverifiedTransaction.productID)")
                
                alertTitle = "Purchases not found!"
                alertMessage = "Unverified restored transaction for product ID: \(unverifiedTransaction.productID)"
            }
            alertIsPresented = true
        }
    
        if !foundTransactions {
            alertTitle = "No Purchases Found"
            alertMessage = "No purchases could be restored."
            alertIsPresented = true
        }
    }
}
