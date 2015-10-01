import UIKit

var ø: Angle = 90
var c = CGPoint(x: 10, y: 0)
c.rotate(ø)

var t = Turtle()
t.color = UIColor.blueColor()
for i in 0..<50 {
    t.forward(i * 2)
    t.left(90)
}

t

var b = Turtle()
for i in 0..<70 {
    b.forward(i * 2)
    b.right(91)
}

b


var colorWheel = [UIColor.redColor(), UIColor.blueColor(), UIColor.orangeColor()]
var col = Turtle()
for i in 0..<70 {
    col.color = colorWheel[i % colorWheel.count]
    col.forward(i * 2)
    col.right(90)
}

col
// The reason it is all the same color is because the line color is determined at the point of drawing.  the context.  And since you basically add all lines to the same path.  add that path to the context.  That means that enter path will get colored the color that is currently set on the context.  A better solution would be to. save an array of paths and a snap shot of the current color.  that way the forward function can parse through that array.  that array would have the path that was just added, plus the color at that current moment.  So you can use a tuple if that makes things easier.  And array of tuple where one item is a path and the second item is a color.