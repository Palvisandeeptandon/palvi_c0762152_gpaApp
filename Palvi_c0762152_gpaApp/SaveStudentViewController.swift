//
//  SaveStudentViewController.swift
//  Palvi_c0762152_gpaApp
//  Copyright © 2019 Palvi. All rights reserved.
//

import UIKit

protocol SaveStudentViewControllerDelegate: class {
    func saveStudentData(student: Student)
}

class SaveStudentViewController: UIViewController {

    /// Variables
    @IBOutlet weak var textFieldFirstName: UITextField!
    @IBOutlet weak var textFieldLastName: UITextField!
    @IBOutlet weak var textFieldStudentID: UITextField!
    
    weak var delegate: SaveStudentViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /// Method to show text field validation error messages
    /// - Parameters:
    ///   - title: String -  title of the Alert
    ///   - message: String - Message of the Alert
    private func showTextFieldValidationAlertMessage(title: String = "", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// Method for validation of empty text fields
    private func validateTextField() -> Bool {
        if let firstName = self.textFieldFirstName.text, firstName.isEmpty {
            self.showTextFieldValidationAlertMessage(message: "First Name is empty.")
            return false
        } else if let lastName = self.textFieldLastName.text, lastName.isEmpty {
            self.showTextFieldValidationAlertMessage(message: "Last Name is empty.")
            return false
        } else if let studentID = self.textFieldStudentID.text, studentID.isEmpty {
            self.showTextFieldValidationAlertMessage(message: "Student ID is empty.")
            return false
        }
        return true
    }
    
    /// Method to show Alert message for saving student data after validation on clicking save button
    /// - Parameters:
    ///   - title: String -  title of the Alert
    ///   - message: String - Message of the Alert
    private func showSaveAlertMessage(title: String = "", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "No Way!", style: .cancel, handler: nil))
        
        alertController.addAction(UIAlertAction(title: "Yes,I'mSure!", style: .default, handler: { action in
            let studentName = (self.textFieldFirstName.text!) + " " + self.textFieldLastName.text!
            self.showConfirmationAlertMessage(studentName: studentName)
            
            var semesterArray = [Semester]()
            
            for i in 1..<4 {
                let semester = Semester(name: "Semester \(i)", studentGPA: 0.0)
                semesterArray.append(semester)
            }
            
            let student = Student(firstName: self.textFieldFirstName.text!,
                                  lastName: self.textFieldLastName.text!,
                                  studentID: self.textFieldStudentID.text!,
                                  semester: semesterArray)
            
            self.delegate?.saveStudentData(student: student)
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// Method to show confirmation after saving student data on clicking "Yes,I'mSure!" in alert message
    /// - Parameter studentName: String - Name of the student to show in alert
    private func showConfirmationAlertMessage(studentName: String) {
        let alertController = UIAlertController(title: "New Contact Saved", message: "\(studentName) is now a student", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            self.textFieldFirstName.text = ""
            self.textFieldLastName.text = ""
            self.textFieldStudentID.text = ""
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// Method to be called on clicking save button
    /// - Parameter sender: Any
    @IBAction func methodToSaveStudentData(_ sender: Any) {
        if validateTextField() {
            self.showSaveAlertMessage(message: "Are you sure?")
        }
    }
    
}

/// Extension of Save Student View Controller for text field delegate methods
extension SaveStudentViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
