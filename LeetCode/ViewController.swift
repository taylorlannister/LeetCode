//
//  ViewController.swift
//  LeetCode
//
//  Created by 刘志康 on 2020/2/1.
//  Copyright © 2020年 刘志康. All rights reserved.
//

import UIKit
/// Debug时 打印数据 及当前文件名 所属方法名 代码所属行数
func DLog<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
    print("<\((file as NSString).lastPathComponent) : \(line)>, \(method)\n\(message)")
    #endif
}

class ViewController: UIViewController {
    
    struct StackG<Element> {
        private var items = [Element]()
        mutating func push(item:Element) {
            items.append(item)
        }
        mutating func pop() ->Element? {
            return items.removeLast()
        }
        func empty() -> Bool {
            return items.isEmpty
        }
        func peek() ->Element? {
            return items.last
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //
        //        var node = ListNode.init(2)
        //        node.next = ListNode.init(3)
        //        node.next?.next = ListNode.init(4)
        //        node.next?.next = ListNode.init(5)
        //        print(reverseList(node.next)!)
//        DLog(isUnique("abcdee"))
        
        DLog(self.minSubsequence([4,3,10,9,8]))
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
    
    func destCity(_ paths: [[String]]) -> String {
        var map = [String : String]()
        
        for path in paths {
            map[path[0]] = path[1]
        }
        
        var key = paths[0][0]
        while map[key] != nil {
            key = map[key]!
        }
        return key
    }
    func isSubtree(_ s: TreeNode?, _ t: TreeNode?) -> Bool {
        guard let s = s else { return false }
        guard let t = t else { return false }
        if equals(s, t) {
            return true
        }
        return isSubtree(s.left, t) || isSubtree(s.right, t)
    }
    func equals(_ s: TreeNode?, _ t: TreeNode?) -> Bool {
        if (s == nil && t != nil) || (s != nil && t == nil) {
            return false
        }
        guard let s = s, let t = t else { return true }
        if s.val != t.val {
            return false
        }
        return equals(s.left, t.left) && equals(s.right, t.right)
    }
    func minTimeToVisitAllPoints(_ points: [[Int]]) -> Int {
        
        var result = 0
        for (index,point) in points.enumerated(){
            if index != 0 {
                let xdistance = abs((points[index].first ?? 0) - (points[index-1].first ?? 0))
                let ydistance = abs((points[index].last ?? 0) - (points[index-1].last ?? 0))
                xdistance > ydistance ? (result = result + xdistance) : (result = result + ydistance)
            }
        }
        return result
    }
    func getDecimalValue(_ head: ListNode?) -> Int {
        var ans = 0
        var node = head
        while node != nil {
            if let value = node?.val {
                ans += value
            }
            if let next = node?.next {
                ans = ans << 1
                node = next //指向下一个节点
            } else {
                node = nil
            }
        }
        return ans
    }
    func minCount(_ coins: [Int]) -> Int {
        var ans = 0
        for coin in coins {
            coin%2 == 0 ? (ans += coin/2) : (ans += coin/2+1)
        }
        return ans
    }
    func countNegatives(_ grid: [[Int]]) -> Int {
        var ans = 0
        for array in grid{
            for num in array {
                if num < 0 {
                    ans = ans + 1
                }
            }
        }
        return ans
    }
    func removeOuterParentheses(_ S: String) -> String {
        
        var index = 0
        var count = 0
        var resultString = ""
        var stack = StackG<Any>.init()
        for (i,character) in S.enumerated() {
            
            if  character == "("{
                count = count + 1
            }else{
                count = count - 1
            }
            stack.push(item: character)
            if count == 0 {
                var tempString = ""
                while !stack.empty() {
                    tempString.append(stack.pop() as! Character)
                }
                resultString.append(tempString)
            }
        }
        return resultString
        
    }
    func reverseLeftWords(_ s: String, _ n: Int) -> String {
        var headStr = ""
        var lastStr = ""
        for (index,character) in s.enumerated() {
            
            if index < n {
                headStr.append(character)
            }else{
                lastStr.append(character)
            }
        }
        return lastStr+headStr
    }
    func getKthFromEnd(_ head: ListNode?, _ k: Int) -> ListNode? {
        
        var fastNode = head
        var showNode = head
        var k = k
        while fastNode != nil {
            
            if k > 0 {
                k = k - 1
            }else{
                showNode = showNode?.next
            }
            fastNode = fastNode?.next
        }
        return showNode
    }
    func printNumbers(_ n: Int) -> [Int] {
        let max = Int(pow(Double(10), Double(n)))
        var result = [Int](repeating: 0, count: max - 1)
        for i in 0..<max - 1 {
            result[i] = i + 1
        }
        return result
    }
    //递归就可
    func mirrorTree(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else{return nil}
        let right = mirrorTree(root.right)
        let left = mirrorTree(root.left)
        root.left = right
        root.right = left
        return root
    }
    //    arr = [17,18,5,4,6,1]
    //    输出：[18,6,6,6,1,-1]
    func replaceElements(_ arr: [Int]) -> [Int] {
        
        var sortArray:[Int] = []
        var dataArr = arr
        dataArr.reverse()
        var max = -1
        for (i, number) in dataArr.enumerated() {
            
            if i > 0 {
                var temp = dataArr[i-1]
                if temp > max {
                    
                    sortArray.append(temp)
                    max = temp
                }else{
                    sortArray.append(max)
                }
            }else{
                sortArray.append(-1)
            }
        }
        sortArray.reverse()
        return sortArray
    }
    
    //  50.  实现 pow(x, n) ，即计算 x 的 n 次幂函数。
    func myPow(_ x: Double, _ n: Int) -> Double {
        if (n == 0){
            return 1
        }
        var num = x
        var times = n
        var multiplyNum = 1.0
        if times < 0{
            num = 1/num
            times = -times
        }
        while times>0 {
            if times == 1 {
                return num*multiplyNum
            }else{
                if times%2 == 1{
                    multiplyNum = multiplyNum*num
                }
                num = num*num
            }
            times=times/2
        }
        return num*multiplyNum
    }
    // 942. 增减字符串匹配
    func diStringMatch(_ S: String) -> [Int] {
        var ansArray:[Int] = []
        var bigNum = S.count
        var smallNum = 0
        
        for (index,char) in S.enumerated(){
            if char == "I" {
                ansArray.append(smallNum)
                smallNum += 1
            }else{
                ansArray.append(bigNum)
                bigNum -= 1
            }
            if index == S.count - 1 {
                if char == "I" {
                    ansArray.append(smallNum)
                }else{
                    ansArray.append(bigNum)
                }
            }
        }
        return ansArray
    }
    //    507.完美数
    //    对于一个 正整数，如果它和除了它自身以外的所有正因子之和相等，我们称它为“完美数”。
    //    给定一个 整数 n， 如果他是完美数，返回 True，否则返回 False
    func checkPerfectNumber(_ num: Int) -> Bool {
        if num == 1{
            return false
        }
        let num = num
        var index = 2
        var bounds = num/2
        var ans = 1
        while index < bounds {
            if num%index == 0{
                ans = index + num/index + ans
                bounds = num/index
            }
            index = index + 1
        }
        return ans==num
    }
    
    //    728. 自除数
    //
    //    自除数 是指可以被它包含的每一位数除尽的数。
    //
    //    例如，128 是一个自除数，因为 128 % 1 == 0，128 % 2 == 0，128 % 8 == 0。
    //
    //    还有，自除数不允许包含 0 。
    //
    //    给定上边界和下边界数字，输出一个列表，列表的元素是边界（含边界）内所有的自除数。
    
    // 暴力破解
    func selfDividingNumbers(_ left: Int, _ right: Int) -> [Int] {
        
        var ans: [Int] = []
        for val in left...right{
            var tempArray:[Int] = []
            var temp = 0
            var number = val
            var isDividingNumbers = true
            if val < 10{
                ans.append(val)
            }else{
                tempArray.removeAll()
                while number>0 {
                    temp = number%10
                    if temp == 0{
                        isDividingNumbers = false
                    }else{
                        if val%temp != 0{
                            isDividingNumbers = false
                        }
                    }
                    number = number/10
                }
                if isDividingNumbers {
                    ans.append(val)
                }
            }
        }
        return ans
    }
    
    //    204. 计数质数 统计所有小于非负整数 n 的质数的数量。
    //    输入: 10
    //    输出: 4
    //    解释: 小于 10 的质数一共有 4 个, 它们是 2, 3, 5, 7
    
    func countPrimes(_ n: Int) -> Int {
        
        var ans = 0
        var isPrimesArray = [Bool](repeating: true, count: n)
        var i = 2
        let number = n
        while  i < number{
            if (isPrimesArray[i]){
                let index = i
                var sortNumber = 1
                while  sortNumber < index{
                    
                    sortNumber = 2*index
                    isPrimesArray[sortNumber] = false
                    
                }
                i = i+1
            }
        }
        for isPrime in isPrimesArray{
            if isPrime {
                ans = ans + 1
            }
        }
        return ans
    }
    
    
    //    1108. IP 地址无效化
    //    给你一个有效的 IPv4 地址 address，返回这个 IP 地址的无效化版本。
    //
    //    所谓无效化 IP 地址，其实就是用 "[.]" 代替了每个 "."。
    func defangIPaddr(_ address: String) -> String {
        var ans = ""
        let dnsAddress = address
        for char in dnsAddress{
            
            if char == "."{
                ans.append("[.]")
            }else{
                ans.append(char)
            }
        }
        return ans
        // 其实就是遍历字符串替换元素
    }
    
    //    面试题05. 替换空格    请实现一个函数，把字符串 s 中的每个空格替换成"%20"。
    func replaceSpace(_ s: String) -> String {
        var ansStr = ""
        for char in s {
            if char == " "{
                ansStr.append("%20")
            }else{
                ansStr.append(char)
            }
        }
        return ansStr
    }
    
    //    面试题39. 数组中出现次数超过一半的数字
    //    数组中有一个数字出现的次数超过数组长度的一半，请找出这个数字。
    //    你可以假设数组是非空的，并且给定的数组总是存在多数元素。
    
    
    func majorityElement(_ nums: [Int]) -> Int {
        
        var number = nums
        var length = nums.count
        number = number.sorted()
        return number[length/2]
    }
    
    
    func reversePrint(_ head: ListNode?) -> [Int] {
        
        var ans:[Int] = []
        var head = head
        while head != nil {
            ans.append(head?.val ?? 0)
            head = head?.next
        }
        return ans.reversed()
    }
    
    func toLowerCase(_ str: String) -> String {
        
        var ans = ""
        let inputStr = str
        for char in inputStr{
            if char > "A" || char < "Z"{
                ans.append(char.lowercased())
            }
            ans.append(char)
        }
        return str.lowercased()
    }
    
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        
        var leftNode: TreeNode?
        var rightNode: TreeNode?
        var nodeArray:[TreeNode?] = []
        var ansArray:[[Int]] = []
        nodeArray.append(root)
        ansArray.append([root!.val])
        for node in nodeArray {
            
            var sectionArray: [Int] = []
            var sectionNodeArray:[TreeNode?] = []
            leftNode = root?.left
            rightNode = root?.right
            sectionNodeArray.append(leftNode)
            sectionNodeArray.append(rightNode)
        }
        return [[1]]
    }
    
    func levelOrder(_ root: TreeNode?) -> [Int] {
        
        var leftNode: TreeNode?
        var rightNode: TreeNode?
        return [leftNode!.val,rightNode!.val]
        
    }
    
    func reverseString(_ s: inout [Character]) {
        
        var first = 0
        var last = s.count - 1
        while first < last {
            s.swapAt(first, last)
            first = first + 1
            last = last - 1
        }
    }
    
    func isvowl(_ s: String) -> Bool {
        let array = ["a","e","i","o","u","A","E","I","O","U"]
        if array.contains(s){
            return true
        }
        return false
    }
    
    func reverseList(_ head: ListNode?) -> ListNode? {
        
        var pre: ListNode? = nil
        var cur = head
        var next: ListNode? = nil
        ///  每次遍历拿到最后的一个节点
        while cur != nil {
            // 把下一个节点存起来
            next = cur?.next
            // 覆盖掉下一个节点
            cur?.next = pre
            // 把当前节点复制保存起来
            pre = cur
            //
            cur = next
        }
        return pre
    }
    
    func hammingWeight(_ n: Int) -> Int {
        if n == 0 {
            return 0
        }
        var ans:Int = 0
        var n = n
        while n>0 {
            if n%2 == 1{
                ans = ans + 1
            }
            n = n/2
        }
        return ans
    }
    //  递归可破
    func isPowerOfTwo(_ n: Int) -> Bool {
        
        if n == 0 {
            return false
        }
        if n == 1{
            return true
        }
        if n%2 == 1 {
            return false
        }
        return isPowerOfTwo(n/2)
    }
    
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else { return nil }
        let left = invertTree(root.left)
        let right = invertTree(root.right)
        root.left = right
        root.right = left
        return root
    }
    
    func sumZero(_ n: Int) -> [Int] {
        
        var ans:[Int] = n%2 == 0 ? [0] : []
        for index in 1..<(n / 2 + 1) {
            ans.append(contentsOf: [index, -index])
        }
        return ans
     }
//    1309. 解码字母到整数映射
    
    func freqAlphabets(_ s: String) -> String {
        let reverString = s.reversed()
        var  ansString = ""
        var charArray:[String] = []
        for char in reverString{
            charArray.append("\(char)")
        }
        
        for (index,char) in charArray.enumerated(){
                
//            if char == "#"{
//                var temp = Int(charArray[index+1]!) + Int(charArray[index+2]!)*10
                
        var s = s
        var  ansChar = ""
        var decodeStr = ""
        
        for (index, char)in s.enumerated() {
            if (char != "#"){
                decodeStr.append(char)
            }
        }
//        return ansString
    }
        return ansString
    }
//    657. 机器人能否返回原点
    func judgeCircle(_ moves: String) -> Bool {
        var lCount:Int = 0
        var rCount:Int = 0
        var uCount:Int = 0
        var dCount:Int = 0
        for char in moves {
            if "\(char)" == "L"{
                lCount = lCount + 1
            }
            if "\(char)" == "R"{
                rCount = rCount + 1
            }
            if "\(char)" == "U"{
                uCount = uCount + 1
            }
            if "\(char)" == "D"{
                dCount = dCount + 1
            }
        }
        return (lCount == rCount && uCount == dCount)
    }
//    利用set的唯一性
    func isUnique(_ astr: String) -> Bool {
        return Set<Character>(astr).count == astr.count
    }
    
//    1450. 在既定时间做作业的学生人数
    func busyStudent(_ startTime: [Int], _ endTime: [Int], _ queryTime: Int) -> Int {
        var count = 0
        for(index,number) in startTime.enumerated(){
            if endTime[index] > queryTime && queryTime > startTime[index]{
                count = count + 1
            }
        }
        return count
    }
    
    func deleteNode(_ node: ListNode?) {
        node?.val = node?.next?.val ?? 0
        node?.next = node?.next?.next
    }
     // 每一个字符转换之后拼接到Set里面去除重复
    func uniqueMorseRepresentations(_ words: [String]) -> Int {
        let set = [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."];
        var result = Set<String>()
        words.map {
            var s = ""
            $0.map{
                //ASCII数值 a为97
                s.append(set[Int($0.asciiValue!-97)])
            }
            result.insert(s)
        }
        return result.count
    }
//    832. 翻转图像
    func flipAndInvertImage(_ A: [[Int]]) -> [[Int]] {
        let A = A
        var ansArray: [[Int]] = []
        for array in A{
            var n = 0
            var tempArray = array
            var tempValue = -1
            while tempArray.count/2 > n{
                tempValue = tempArray[n]^1
                tempArray[n] = tempArray[tempArray.count-1-n]^1
                tempArray[tempArray.count-1-n] = tempValue
                n = n+1
            }
            if tempArray.count%2 == 1{
                tempArray[tempArray.count/2] = tempArray[tempArray.count/2]^1
            }
            ansArray.append(tempArray)
        }
        return ansArray
    }
    
//    1122. 数组的相对排序
//    func relativeSortArray(_ arr1: [Int], _ arr2: [Int]) -> [Int] {
//        
//    }
//    面试题25. 合并两个排序的链表
//    简单递归可破
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil{
            return l2
        }
        if l2 == nil{
            return l1
        }else {
            l2?.next = mergeTwoLists(l1, l2?.next)
            return l2
        }
    }
    
    func heightChecker(_ heights: [Int]) -> Int {
        var ans = 0
        for (i,v) in heights.sorted().enumerated() {
            if v != heights[i]{
                ans += 1
            }
        }
        return 0
    }
    
//    1221. 分割平衡字符串
//    在一个「平衡字符串」中，'L' 和 'R' 字符的数量是相同的。
//
//    给出一个平衡字符串 s，请你将它分割成尽可能多的平衡字符串。
//
//    返回可以通过分割得到的平衡字符串的最大数量。
    //    示例 1：
//    输入：s = "RLRRLLRLRL"
//    输出：4
//    解释：s 可以分割为 "RL", "RRLL", "RL", "RL", 每个子字符串中都包含相同数量的 'L' 和 'R'。
    //    示例 2：
//    输入：s = "RLLLLRRRLR"
//    输出：3
//    解释：s 可以分割为 "RL", "LLLRRR", "LR", 每个子字符串中都包含相同数量的 'L' 和 'R'。
//    示例 3：
//
//    输入：s = "LLLLRRRR"
//    输出：1
//    解释：s 只能保持原样 "LLLLRRRR".
    func balancedStringSplit(_ s: String) -> Int {
//  栈的思维去解决就好
        let s = s
        var ans = 0
        var leftCount = 0
        for char in s {
            if char == "L" {
                leftCount = leftCount + 1
            }
            if char == "R" {
                leftCount = leftCount - 1
            }
            if leftCount == 0{
                ans = ans + 1
            }
        }
        return ans
    }

    func sortedSquares(_ A: [Int]) -> [Int] {
        var ansArray:[Int] = []
        var A = A
        for element in A{
            ansArray.append(element*element)
        }
        ansArray.sort()
        return ansArray
    }
    // 先排序， 再取奇数位元素想家
   func arrayPairSum(_ nums: [Int]) -> Int {
       var nums = nums.sorted()
       var ans = 0
    for (index, num) in nums.enumerated(){
        if index%2 == 0{
            ans += num
        }
       }
       return ans
    }
    
//    func reverseWords(_ s: String) -> String {
//        if s == "" { return s }
//        var result = ""
//        var arr = s.split(separator: " ")
//        arr.forEach {
//            result += String($0.reversed())
//            result += " "
//        }
//        result.removeLast()
//        return result
//    }
    
    func reverseWords(_ s: String) -> String {
        if s == "" {
             return s
        }
        var result = ""
        let arr = s.split(separator:" ")
        arr.forEach{
            result += String($0.reversed())
            result += " "
        }
        result.removeLast()
        return result
    }
    
//    1380. 矩阵中的幸运数
    func luckyNumbers (_ matrix: [[Int]]) -> [Int] {
        var count = 0
        var ansArray:[Int] = []
//        var ansArray = Set<Int>()
        var minArray:[Int] = []
        var minIndex = 0
        var indexArray:[Int] = []
        while count < matrix.count{
            var min:Int = 0
            for(index,element) in matrix[count].enumerated(){
                if index == 0 {
                    min = element
                    minIndex = 0
                }
                if element < min{
                    min = element
                    minIndex = index
                }
            }
//            minArray.append(min)
//            indexArray.append(minIndex)
            var isMax: Bool = true
            for(index,tempArray) in matrix.enumerated(){
                
                if tempArray[minIndex] > min{
                    isMax = false
                }
            }
            if isMax{
                ansArray.append(min)
            }
            count += 1
        }
        return Array(ansArray)
    }
    
//    1370. 上升下降字符串
//    给你一个字符串 s ，请你根据下面的算法重新构造字符串：
//    从 s 中选出 最小 的字符，将它 接在 结果字符串的后面。
//    从 s 剩余字符中选出 最小 的字符，且该字符比上一个添加的字符大，将它 接在 结果字符串后面。
//    重复步骤 2 ，直到你没法从 s 中选择字符。
//    从 s 中选出 最大 的字符，将它 接在 结果字符串的后面。
//    从 s 剩余字符中选出 最大 的字符，且该字符比上一个添加的字符小，将它 接在 结果字符串后面。
//    重复步骤 5 ，直到你没法从 s 中选择字符。
//    重复步骤 1 到 6 ，直到 s 中所有字符都已经被选过。
//    在任何一步中，如果最小或者最大字符不止一个 ，你可以选择其中任意一个，并将其添加到结果字符串。
//    请你返回将 s 中字符重新排序后的 结果字符串 。
//    示例 1：
//    输入：s = "aaaabbbbcccc"
//    输出："abccbaabccba"
//    解释：第一轮的步骤 1，2，3 后，结果字符串为 result = "abc"
//    第一轮的步骤 4，5，6 后，结果字符串为 result = "abccba"
//    第一轮结束，现在 s = "aabbcc" ，我们再次回到步骤 1
//    第二轮的步骤 1，2，3 后，结果字符串为 result = "abccbaabc"
//    第二轮的步骤 4，5，6 后，结果字符串为 result = "abccbaabccba"

    func sortString(_ s: String) -> String {
        //题解:首先桶排序统计次数，再然后遍历拼接就好了
        let s = s
        var timesArray = [Int](repeating: 0, count: 26)
        var ans = ""
        for char in s{
            timesArray[Int(char.asciiValue!) - 97] += 1
        }
        var needReserve = false
        while ans.count < s.count {
            var tempStr = ""
            for(index,number) in timesArray.enumerated(){
                if number > 0{
                    timesArray[index] -= 1
                    let char = Character(Unicode.Scalar(index + 97)!)
                    tempStr.append(char)
                }
            }
            (needReserve == true) ? (ans.append(String(tempStr.reversed()))) : (ans.append(tempStr))
            needReserve = !needReserve
        }
        return ans
    }
            
            
    func generateTheString(_ n: Int) -> String {
        var time = n
        var ans = ""
        var k = 0
        if n%2 == 0{
            k = 1
        }
        while time>k {
            ans.append("a")
            time = time - 1
        }
        if n%2 == 0{
            ans.append("b")
        }
        return ans
    }
//    852. 山脉数组的峰顶索引
// 题解：其实就是找最大值，把下标拿出来。 二分法其实也不错
    func peakIndexInMountainArray(_ A: [Int]) -> Int {
        
        let array = A.sorted()
        let max = array.last
        for (index,element) in A.enumerated(){
            if element == max{
                return index
            }
        }
        return 0
    }
    
//    1403. 非递增顺序的最小子序列
//    运用了sorted偷懒， 否则应该是一边排序。一边相加进行判断
    func minSubsequence(_ nums: [Int]) -> [Int] {
        
        var count = 0
        var ansArray:[Int] = []
        var tempArray = nums.sorted().reversed()
        for (index,element) in nums.enumerated() {
            count += element
        }
        var combine = 0
        for (index,element) in tempArray.enumerated() {
            combine += element
            if combine > count - combine{
                ansArray.append(element)
                return ansArray
            }else{
                ansArray.append(element)
            }
        }
        return ansArray
    }
//    292. Nim 游戏  余n的思路可以解决
    func canWinNim(_ n: Int) -> Bool {
        return (n%4 == 0) ? false : true
    }
//    559. N叉树的最大深度
//    给定一个 N 叉树，找到其最大深度。
//    最大深度是指从根节点到最远叶子节点的最长路径上的节点总数。
//    例如，给定一个 3叉树 :
    func maxDepth(_ root: Node?) -> Int {
        guard let root = root else {return 0}
        var ans:Int = 0
        for child in root.children {
            ans = max(ans, maxDepth(child))
        }
        return ans + 1
    }
    
}
