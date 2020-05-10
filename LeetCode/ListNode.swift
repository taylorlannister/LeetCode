//
//  ListNode.swift
//  LeetCode
//
//  Created by 刘志康 on 2020/5/10.
//  Copyright © 2020 刘志康. All rights reserved.
//

import UIKit

class ListNode: NSObject {
    var val: Int
    var next:ListNode?
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}
