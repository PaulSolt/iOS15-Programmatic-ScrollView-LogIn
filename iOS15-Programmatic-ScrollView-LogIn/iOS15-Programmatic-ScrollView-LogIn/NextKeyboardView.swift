//
//  NextKeyboardView.swift
//  iOS15-Programmatic-ScrollView-LogIn
//
//  Created by Paul Solt on 5/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import UIKit

/// Use to go to next field or dismiss a keyboard
/// If it's connected, use a UITextFieldDelegate to make the next view becomeFirstResponder, else resignFirstResponder
protocol NextView: UIView {
    var nextView: UIView? { get set }
}
