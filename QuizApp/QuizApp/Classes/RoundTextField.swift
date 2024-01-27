//
//  RoundTextField.swift
//  QuizApp
//
//  Created by Vladislav Zolotov on 2023-07-26.
//

import UIKit

class RoundTextField: UITextField {

    override func layoutSubviews() {
        super.layoutSubviews()
        // Set the corner radius to half of the height to make it round
        self.layer.cornerRadius = self.bounds.height / 2
        self.clipsToBounds = true
    }

}
