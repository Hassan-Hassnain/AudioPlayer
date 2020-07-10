//
//  CustomButton.swift
//  AudioPlayer
//
//  Created by اسرارالحق  on 10/07/2020.
//  Copyright © 2020 اسرارالحق . All rights reserved.
//

import UIKit

class RoundedCornerView: UIButton {

    required init?(coder: NSCoder) {
           super.init(coder: coder)
        layer.cornerRadius = frame.size.height/2
       }

}
