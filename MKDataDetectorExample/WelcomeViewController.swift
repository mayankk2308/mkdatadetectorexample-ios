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
        eventTypeField.delegate = self
        addressTypeField.delegate = self
        // try other fields such as `addressTypeField` here
        if let eventLabelResults = dataDetectorService.extractInformation(fromTextBody: eventLabel.text!, withResultTypes: .date, .link, .address, .phoneNumber) {
            eventLabel.highlightData(withResults: eventLabelResults, withColor: .purple)
        }
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
    
    func highlightData(withResults results: [GenericAnalysisResult], withColor color: UIColor) {
        let dataDetectorService = MKDataDetectorService()
        guard let attributedText = dataDetectorService.attributedText(fromAnalysisResults: results, withColor: color.cgColor) else { return }
        self.attributedText = attributedText
    }
}

