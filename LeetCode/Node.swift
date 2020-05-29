//
//  Node.swift
//  LeetCode
//
//  Created by 刘志康 on 2020/5/29.
//  Copyright © 2020 刘志康. All rights reserved.
//

import UIKit

class Node: NSObject {
    var val: Int
    var children: [Node]
    public init(_ val: Int) {
        self.val = val
        self.children = []
    }
}
