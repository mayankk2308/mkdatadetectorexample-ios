//
//  ViewController.swift
//  MKDataDetectorExample
//
//  Created by Mayank Kumar on 7/17/17.
//  Copyright © 2017 Mayank Kumar. All rights reserved.
//

import UIKit
import MKDataDetector

class WelcomeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var eventLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var linkLabel: UILabel!
    @IBOutlet var eventTypeField: UITextField!
    @IBOutlet var addressTypeField: UITextField!
    
    let dataDetectorService = MKDataDetectorService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventLabel.highlightDates()
        addressLabel.highlightAddresses()
        linkLabel.highlightLinks()
        eventTypeField.delegate = self
        addressTypeField.delegate = self
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == eventTypeField {
            guard let text = textField.text else { return }
            if let results = dataDetectorService.extractDates(fromTextBody: text) {
                guard let analysisResult = results.first else { return }
                let attributedString = NSMutableAttributedString(string: analysisResult.source)
                attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.purple, range: analysisResult.rangeInSource)
                textField.attributedText = attributedString
            }
        }
        else {
            guard let text = textField.text else { return }
            if let results = dataDetectorService.extractAddresses(fromTextBody: text) {
                guard let analysisResult = results.first else { return }
                let attributedString = NSMutableAttributedString(string: analysisResult.source)
                attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.purple, range: analysisResult.rangeInSource)
                textField.attributedText = attributedString
            }
        }
    }

}

extension UILabel {
    
    func highlightDates() {
        let dataDetectorService = MKDataDetectorService()
        guard let textBody = text else { return }
        guard let dates = dataDetectorService.extractDates(fromTextBody: textBody) else { return }
        guard let analysisResult = dates.first else { return }
        let attributedString = NSMutableAttributedString(string: analysisResult.source)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.purple, range: analysisResult.rangeInSource)
        attributedText = attributedString
    }
    
    func highlightAddresses() {
        let dataDetectorService = MKDataDetectorService()
        guard let textBody = text else { return }
        guard let dates = dataDetectorService.extractAddresses(fromTextBody: textBody) else { return }
        guard let analysisResult = dates.first else { return }
        let attributedString = NSMutableAttributedString(string: analysisResult.source)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.orange, range: analysisResult.rangeInSource)
        attributedText = attributedString
    }
    
    func highlightLinks() {
        
        let dataDetectorService = MKDataDetectorService()
        guard let textBody = text else { return }
        guard let dates = dataDetectorService.extractLinks(fromTextBody: textBody) else { return }
        guard let analysisResult = dates.first else { return }
        let attributedString = NSMutableAttributedString(string: analysisResult.source)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: analysisResult.rangeInSource)
        attributedText = attributedString
    }
}

