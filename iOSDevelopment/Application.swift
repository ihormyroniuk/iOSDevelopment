//
//  Application.swift
//  EverythingAboutEverything
//
//  Created by Ihor Myroniuk on 10/17/19.
//  Copyright © 2019 Ihor Myroniuk. All rights reserved.
//

import UIKit
import AUIKit

final class Application: AUIEmptyApplication {
    
    // MARK: Launching
    
    override func didFinishLaunching() {
        super.didFinishLaunching()
        startPresentation()
    }
    
    // MARK: Presentation
    
    var presentation: Presentation?
    
    private func startPresentation() {
        presentation = IPhonePresentation(window: window ?? UIWindow())
        presentation?.start()
    }
    
}
