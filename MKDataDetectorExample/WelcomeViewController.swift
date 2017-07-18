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
                textField.attributedText = dataDetectorService.attributedText(fromAnalysisResults: results, withColor: UIColor.yellow.cgColor)
            }
        }
        else {
            guard let text = textField.text else { return }
            if let results = dataDetectorService.extractAddresses(fromTextBody: text) {
                textField.attributedText = dataDetectorService.attributedText(fromAnalysisResults: results, withColor: UIColor.green.cgColor)
            }
        }
    }

}

extension UILabel {
    
    func highlightDates() {
        let dataDetectorService = MKDataDetectorService()
        guard let textBody = text else { return }
        guard let dates = dataDetectorService.extractDates(fromTextBody: textBody) else { return }
        attributedText = dataDetectorService.attributedText(fromAnalysisResults: dates, withColor: UIColor.purple.cgColor)
    }
    
    func highlightAddresses() {
        let dataDetectorService = MKDataDetectorService()
        guard let textBody = text else { return }
        guard let addresses = dataDetectorService.extractAddresses(fromTextBody: textBody) else { return }
        attributedText = dataDetectorService.attributedText(fromAnalysisResults: addresses, withColor: UIColor.orange.cgColor)
    }
    
    func highlightLinks() {
        
        let dataDetectorService = MKDataDetectorService()
        guard let textBody = text else { return }
        guard let links = dataDetectorService.extractLinks(fromTextBody: textBody) else { return }
        attributedText = dataDetectorService.attributedText(fromAnalysisResults: links, withColor: UIColor.blue.cgColor)
    }
}

