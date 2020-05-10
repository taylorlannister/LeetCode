//
//  ViewController.swift
//  LeetCode
//
//  Created by 刘志康 on 2020/2/1.
//  Copyright © 2020年 刘志康. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

//       104. 二叉树的最大深度
    func maxDepth(_ root: TreeNode?) -> Int {
        if(root == nil) {
            return 0
        }else{
            let left = maxDepth(root!.left)
            let right = maxDepth(root!.right)
            return max(left, right) + 1
        }
}

//    461. 汉明距离
//    两个整数之间的汉明距离指的是这两个数字对应二进制位不同的位置的数目。
//
//    给出两个整数 x 和 y，计算它们之间的汉明距离。
//
//    注意：
//    0 ≤ x, y < 231.
//
//    示例:
//
//    输入: x = 1, y = 4
//
//    输出: 2
//
//    解释:
//    1   (0 0 0 1)
//    4   (0 1 0 0)
//           ↑   ↑
//
//    上面的箭头指出了对应二进制位不同的位置
    func hammingDistance(_ x: Int, _ y: Int) -> Int {
        var x = x
        var y = y
        var ans = 0
        var bigNum = max(x, y)
        while  bigNum>0{
            if x%2 != y%2{
                ans = ans + 1
            }
            x = x/2
            y = y/2
            bigNum = bigNum/2
        }
        return ans
    }
    

}
