//
//  QuotesTableViewController.swift
//  Inspire
//
//  Created by Badal  Aryal on 01/03/2024.
//


import UIKit
import StoreKit

class QuotesTableViewController: UITableViewController, SKPaymentTransactionObserver {
    
    
    
    let productID = "com.badalaryal.Inspire.PremiumQuotes"
    
    var quotesToShow = [
        "Our greatest glory is not in never falling, but in rising every time we fall. — Confucius",
        "All our dreams can come true, if we have the courage to pursue them. – Walt Disney",
        "It does not matter how slowly you go as long as you do not stop. – Confucius",
        "Everything you’ve ever wanted is on the other side of fear. — George Addair",
        "Success is not final, failure is not fatal: it is the courage to continue that counts. – Winston Churchill",
        "Hardships often prepare ordinary people for an extraordinary destiny. – C.S. Lewis"
    ]
    
    let premiumQuotes = [
        "Believe in yourself. You are braver than you think, more talented than you know, and capable of more than you imagine. ― Roy T. Bennett",
        "I learned that courage was not the absence of fear, but the triumph over it. The brave man is not he who does not feel afraid, but he who conquers that fear. – Nelson Mandela",
        "There is only one thing that makes a dream impossible to achieve: the fear of failure. ― Paulo Coelho",
        "It’s not whether you get knocked down. It’s whether you get up. – Vince Lombardi",
        "Your true success in life begins only when you make the commitment to become excellent at what you do. — Brian Tracy",
        "Believe in yourself, take on your challenges, dig deep within yourself to conquer fears. Never let anyone bring you down. You got to keep going. – Chantal Sutherland"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        SKPaymentQueue.default().add(self)
    }
    
    func configureNavigation(){
        self.navigationController?.navigationBar.barTintColor = .systemGreen
        self.navigationController?.navigationBar.backgroundColor = .systemGreen
        
        let attributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font:UIFont(name: "Verdana", size: 17)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return quotesToShow.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath)
        if indexPath.row < quotesToShow.count {
            cell.textLabel?.text = quotesToShow[indexPath.row]
            cell.textLabel?.numberOfLines = 0
        } else {
            cell.textLabel?.text = "Get More Quotes"
            cell.textLabel?.textColor = UIColor(named: "blue")
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    

    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == quotesToShow.count {
            buyPremiumQuotes()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - In-App Purchase Methods
    
    func buyPremiumQuotes() {
        
        // the queue of payment transactions to be processed by Appstore
        if SKPaymentQueue.canMakePayments(){
            // can make payment
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
        } else {
            // can't make payments
            print("User Can't Make Payments")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                // User payment sucessful
                print("Transaction Sucessful")
                SKPaymentQueue.default().finishTransaction(transaction)
            } else if transaction.transactionState == .failed{
                //payment failed
                print("Transaction Failed")
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }
    
    
        @IBAction func restorePressed(_ sender: UIBarButtonItem) {
        }
        
  


}
