//
//  TreeNode.swift
//  LeetCode
//
//  Created by 刘志康 on 2020/5/10.
//  Copyright © 2020 刘志康. All rights reserved.
//

import UIKit

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}
