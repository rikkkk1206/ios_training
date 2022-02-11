//
//  DismissSegue.swift
//  Training-2
//
//  Created by RIKU on 2022/02/11.
//

import UIKit

class DismissSegue: UIStoryboardSegue {
    override func perform() {
        self.source.dismiss(animated: true, completion: nil)
    }
}
