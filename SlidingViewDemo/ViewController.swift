//
//  ViewController.swift
//  SlidingViewDemo
//
//  Created by Digices LLC on 6/12/17.
//  Copyright © 2017 Digices LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

  // MARK: - IBOutlets
  
  @IBOutlet weak var scrollView: UIScrollView!
  
  @IBOutlet weak var topField: UITextField!
  
  @IBOutlet weak var midField: UITextField!
  
  @IBOutlet weak var lowField: UITextField!
  
  // MARK: - Private Properties
  
  private var keyboardTopY: CGFloat?
  
  private var fieldBottomY: CGFloat?
  
  private var contentOffsetY: CGFloat!
  
  // MARK: - ViewController (self)
  
  func keyboardWillShow(notification: Notification) {
    if let userInfo = notification.userInfo {
      if let frameInfo = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
        self.keyboardTopY = frameInfo.cgRectValue.minY
        self.contentOffsetY = self.scrollView.contentOffset.y
        if let fieldPos = self.fieldBottomY {
          if (fieldPos + 50) > self.keyboardTopY! {
            let raisedBy = (fieldPos - self.keyboardTopY!) + 50
            let offset = self.scrollView.contentOffset
            let tempOffset = CGPoint(x: offset.x, y: offset.y + raisedBy)
            self.scrollView.setContentOffset(tempOffset, animated: true)
          }
          if fieldPos < 50 {
            let offset = self.scrollView.contentOffset
            let tempOffset = CGPoint(x: offset.x, y: offset.y - 50)
            self.scrollView.setContentOffset(tempOffset, animated: true)
          }
        }
      }
    }
  }
  
  func didBeginEditing(textField: UITextField) {
    self.fieldBottomY = textField.fieldPosition(contentOffset: self.scrollView.contentOffset)
  }
  
  func dismissKeyboard() {
    self.view.endEditing(true)
    let originalOffset = CGPoint(x: self.scrollView.contentOffset.x, y: self.contentOffsetY)
    self.scrollView.setContentOffset(originalOffset, animated: true)
  }
  
  // MARK:- UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard)))
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
    self.topField.addTarget(self, action: #selector(self.didBeginEditing), for: .editingDidBegin)
    self.midField.addTarget(self, action: #selector(self.didBeginEditing), for: .editingDidBegin)
    self.lowField.addTarget(self, action: #selector(self.didBeginEditing), for: .editingDidBegin)
    self.topField.delegate = self
    self.midField.delegate = self
    self.lowField.delegate = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: - UITextFieldDelegate
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.dismissKeyboard()
    return false
  }

}

