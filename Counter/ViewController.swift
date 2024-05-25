//
//  ViewController.swift
//  Counter
//
//  Created by Anna Shvets on 24.05.2024.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak private var counterLabel: UILabel!
    @IBOutlet weak private var consoleTextView: UITextView!
    @IBOutlet weak private var consoleView: UIView!
    private var counter = 0
    
    private enum message: String {
        case cleared = "История очищена"
        case void = "Здесь будут храниться изменения"
        case reseted = "значение сброшено"
        case edited = "значение изменено на"
        case tryToDownZero = "попытка уменьшить значение счётчика ниже 0"
    }
    
    private var currentDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        
        return dateFormatter.string(from: Date())
    }
    private var consoleIsClear: Bool {
        let isCleared = consoleTextView.text == message.cleared.rawValue
        let isVoid = consoleTextView.text == message.void.rawValue
        return isCleared || isVoid
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        consoleView.layer.cornerRadius = 8.0
        consoleTextView.text = message.void.rawValue
        consoleTextView.textColor = UIColor.gray
    }
    
    private func updateCount(_ value: Int) {
        if value > counter {
            let delta = value - counter
            logToConsole("\(message.edited.rawValue) +\(delta)")
        } else if value < counter {
            let delta = counter - value
            logToConsole("\(message.edited.rawValue) -\(delta)")
        }
        
        counter = value
        counterLabel.text = String(counter)
    }
    
    private func logToConsole(_ message: String) {
        let messageWithDate = "\(currentDate): \(message)"
        
        if consoleIsClear {
            consoleTextView.text = messageWithDate
            consoleTextView.textColor = UIColor.darkText
            return
        }
        
        consoleTextView.text = consoleTextView.text + "\n" + messageWithDate
        
        let range = NSMakeRange(consoleTextView.text.count - 1, 0)
        consoleTextView.scrollRangeToVisible(range)
    }
    
    @IBAction func incrementCount(_ sender: Any) {
        updateCount(counter + 1)
    }
    
    @IBAction func decrementCount(_ sender: Any) {
        if counter <= 0 {
            logToConsole(message.tryToDownZero.rawValue)
            return
        }
        
        updateCount(counter - 1)
    }
    
    @IBAction func resetCount(_ sender: Any) {
        updateCount(0)
        logToConsole(message.reseted.rawValue)
    }
    
    @IBAction func clearConsole(_ sender: Any) {
        consoleTextView.text = message.cleared.rawValue
        consoleTextView.textColor = UIColor.gray
    }
}

