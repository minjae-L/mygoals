//
//  AddViewController.swift
//  goalsApp
//
//  Created by 이민재 on 2021/05/25.
//  Copyright © 2021 이민재. All rights reserved.
//
// 시간계획표중에서 계획을 추가하는 부분
// 제목, 내용, 시작시간과 종료시간을 한 문자열로 보내는 곳
 

import UIKit

class AddViewController: UIViewController  {
    
    var delegate: ViewController?
    
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var discriptionTextView: UITextView!
    
    @IBAction func addWork(_ sender: Any) {
        guard let titleText = titleTextField.text else { return }
        guard let discText = discriptionTextView.text  else { return }
        var str : (String)
        if discText == "내용입력" {
            str = "\(titleText)@@@"
        } else {
            str = "\(titleText)@@@" + "\(discText)"
        }
        delegate?.titleArr.append(str)
        delegate?.scheduleTableView.reloadData()
        print(delegate?.titleArr)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        discriptionTextView.delegate = self
        titleTextField.borderStyle = .none
        textViewSetupView()
        super.viewDidLoad()
    }
    

    
}

extension AddViewController: UITextViewDelegate {
    
    func textViewSetupView() {
        if discriptionTextView.text == "내용입력" {
            discriptionTextView.text = ""
            discriptionTextView.textColor = UIColor.black
        } else if discriptionTextView.text == ""{
            discriptionTextView.text = "내용입력"
            discriptionTextView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewSetupView()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if discriptionTextView.text == "" {
            textViewSetupView()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            discriptionTextView.resignFirstResponder()
        }
        return true
    }
    

}


