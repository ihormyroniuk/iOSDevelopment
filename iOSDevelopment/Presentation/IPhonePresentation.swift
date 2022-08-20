//
//  IPhonePresentation.swift
//  EverythingAboutEverything
//
//  Created by Ihor Myroniuk on 10/17/19.
//  Copyright © 2019 Ihor Myroniuk. All rights reserved.
//

import UIKit
import AUIKit

class IPhonePresentation: AUIWindowPresentation, Presentation {
    
    func start() {
        let screenController = SignUpScreenController()
        window.rootViewController = screenController
        window.makeKeyAndVisible()
    }
    
}
