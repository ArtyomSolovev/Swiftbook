//
//  ViewController.swift
//  test
//
//  Created by Артем Соловьев on 02.02.2021.
//

import UIKit

class ViewController: UIViewController {
    var uiElemets = ["UISegmentedControl", "UIlabel", "Slider", "UITextField", "UIButton", "UIDatePicker"]
    
    var selectedElement: String?
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var switchLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.value = 1
        
        label.text = String(slider.value)
        label.font = label.font.withSize(35)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        segmentedControl.insertSegment(withTitle: "Third", at: 2, animated: true)
        
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.minimumTrackTintColor = .yellow
        slider.maximumTrackTintColor = .red
        slider.thumbTintColor = .blue//цвет бегунка
        
        datePicker.locale = Locale(identifier: "ru_RU")
        
        choiceUIElement()
        createToolBar()
    }
    func choiceUIElement(){
        let elementPicker = UIPickerView()
        elementPicker.delegate = self// назначение делегатом, чтобы можно было воспользоваться данными pickerView
        
        textField.inputView = elementPicker
        //Custamization
        elementPicker.backgroundColor = .brown
        
    }
    func hideAllElements(){
        segmentedControl.isHidden = true
        label.isHidden = true
        slider.isHidden = true
        doneButton.isHidden = true
        datePicker.isHidden = true
    }
    func createToolBar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()//встриваем под размер
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))// 1 - название, 2 - обычный текст, 4 - селектор, который вызывает какую-то функцию
        toolbar.setItems([doneButton], animated: true)// добавляем нашу кнопку в тулбар
        toolbar.isUserInteractionEnabled = true//позволяем взаимодействовать пользоваетелю с даннвым элементом
        textField.inputAccessoryView = toolbar// встраиваем тулбар в виде надстройки над клавиатурой
        //Custamization
        toolbar.tintColor = .white
        toolbar.barTintColor = .brown
    }
    @objc func dismissKeyboard(){// если обращаться к селектору, то нужно прописать:@objc
        view.endEditing(true)
    }
    @IBAction func sliderAction(_ sender: UISlider) {
        label.text = String(sender.value)
        let backGroundColor = self.view.backgroundColor
        self.view.backgroundColor = backGroundColor?.withAlphaComponent(CGFloat(sender.value))
    }
    @IBAction func donePressed(_ sender: UIButton) {
        guard textField.text?.isEmpty == false else {return}
        if let _ = Double(textField.text!){// нижнее подчерктвание используется для переменной, которая никогда не используется явно
            let alert = UIAlertController(title: "Wrong format", message: "Please enter your name", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        } else{
            label.text = textField.text
            textField.text = nil
        }
    }
    @IBAction func changeDate(_ sender: UIDatePicker) {
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .medium
        dateFormater.locale = Locale(identifier: "ru_RU")
        let dateValue = dateFormater.string(from: sender.date)
        label.text = dateValue
    }
    @IBAction func switchAction(_ sender: UISwitch) {
        segmentedControl.isHidden = !segmentedControl.isHidden
        label.isHidden = !label.isHidden
        slider.isHidden = !slider.isHidden
        textField.isHidden = !textField.isHidden
        datePicker.isHidden = !datePicker.isHidden
        doneButton.isHidden = !doneButton.isHidden
        
        if sender.isOn{
            switchLabel.text = "Отоброзить все элементы"
        } else{
            switchLabel.text = "Скрыть все элементы"
        }
    }
    @IBAction func choiceSegment(_ sender: UISegmentedControl) {
        label.isHidden = false
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            label.text = "The first segment is selected"
            label.textColor = .red
        case 1:
            label.text = "The second segment is selected"
            label.textColor = .blue
        case 2:
            label.text = "The third segment is selected"
            label.textColor = .green
        default:
            print("Error")
        }
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1//возвразает количество барабанов, которые мы будем использовать
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return uiElemets.count//возвращает количество элементов, которые будут доступны pickerview, мы ограничеваем количесвто этих элементов колисчеством элементов массива
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return uiElemets[row]//позволяет отображать в каждой строке пиервью определенное значение, мы ограничеваем количесвто этих элементов колисчеством элементов массива uiElements
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {//позволяет работать с выбранным элементом
        selectedElement = uiElemets[row]
        textField.text = selectedElement
        
        switch row{
        case 0:
            hideAllElements()
            segmentedControl.isHidden = false
        case 1:
            hideAllElements()
            label.isHidden = false
        case 2:
            hideAllElements()
            slider.isHidden = false
        case 3:
            hideAllElements()
        case 4:
            hideAllElements()
            doneButton.isHidden = false
        case 5:
            hideAllElements()
            datePicker.isHidden = false
        default:
            hideAllElements()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerViewLabel = UILabel()
        
        if let currentLabel = view as? UILabel{
            pickerViewLabel = currentLabel
        } else{
            pickerViewLabel = UILabel()
        }
        pickerViewLabel.textColor = .white
        pickerViewLabel.textAlignment = .center
        pickerViewLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 23)
        pickerViewLabel.text = uiElemets[row]
        
        return pickerViewLabel
    }
}
