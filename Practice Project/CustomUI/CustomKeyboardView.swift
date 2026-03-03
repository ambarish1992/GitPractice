//
//  CustomKeyboardView.swift
//  Practice Project
//
//  Created by Tharik Batcha on 03/03/26.
//

import UIKit

class CustomKeyboardView: UIView {
    
    weak var textField: UITextField?
    
    private let normalKeyHeight: CGFloat = 50
    private let bottomKeyHeight: CGFloat = 45
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        
        backgroundColor = UIColor(red: 0.82, green: 0.82, blue: 0.85, alpha: 1)
        
        let rows = [
            ["1","2","3","4","5","6","7","8","9","0"],
            ["q","w","e","r","t","y","u","i","o","p"],
            ["a","s","d","f","g","h","j","k","l"],
            ["z","x","c","v","b","n","m"]
        ]
        
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.spacing = 8
        mainStack.alignment = .fill
        mainStack.distribution = .fill
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 8)
        ])
        
        // 🔥 Normal rows
        for row in rows {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 6
            rowStack.distribution = .fillEqually
            
            rowStack.heightAnchor.constraint(equalToConstant: normalKeyHeight).isActive = true
            
            for key in row {
                rowStack.addArrangedSubview(makeKey(title: key))
            }
            
            mainStack.addArrangedSubview(rowStack)
        }
        
        // 🔥 Bottom row
        let bottomRow = UIStackView()
        bottomRow.axis = .horizontal
        bottomRow.spacing = 6
        bottomRow.distribution = .fillEqually
        
        bottomRow.heightAnchor.constraint(equalToConstant: bottomKeyHeight).isActive = true
        
        let space = makeKey(title: "space")
        let enter = makeKey(title: "enter")
        let delete = makeKey(title: "⌫")
        
        bottomRow.addArrangedSubview(space)
        bottomRow.addArrangedSubview(enter)
        bottomRow.addArrangedSubview(delete)
        
        mainStack.addArrangedSubview(bottomRow)
        
        NSLayoutConstraint.activate([
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    private func makeKey(title: String) -> UIButton {
        
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)   // 🔥 Black text
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(keyTapped(_:)), for: .touchUpInside)
        return button
    }
    
    @objc private func keyTapped(_ sender: UIButton) {
        
        guard let textField = textField else { return }
        let title = sender.title(for: .normal) ?? ""
        
        switch title {
            
        case "⌫":
            textField.deleteBackward()
            
        case "space":
            textField.insertText(" ")
            
        case "enter":
            textField.resignFirstResponder()
            
        default:
            textField.insertText(title)
        }
    }
}
