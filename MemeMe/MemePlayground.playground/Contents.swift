//: Playground - noun: a place where people can play

import UIKit

//var m = Meme("This is a test", "This is a test, too", nil, nil)

var s = "This is a test"
var t = "the end of the string".lastPathComponent
var x = s.substringWithRange(Range(start: s.startIndex, end: advance(s.startIndex, 8)))
var y = t.substringWithRange(Range(start: advance(t.endIndex, -8), end: t.endIndex))
var z = "\(x)...\(y)"
