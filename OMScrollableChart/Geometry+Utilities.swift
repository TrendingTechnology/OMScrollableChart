// Copyright 2018 Jorge Ouahbi
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
import Foundation
import CoreGraphics

// swiftlint:disable identifier_name shorthand_operator

struct Point3D {
    var x:CGFloat, y:CGFloat, z:CGFloat;
}
struct Segment3D {
    var  P0:Point3D;
    var  P1:Point3D;
};

extension Point3D {
    func dot( point:Point3D) -> CGFloat {
        return ((self).x * (point).x + (self).y * (point).y + (self).z * (point).z);
    }
    
    func norm( ) -> CGFloat {
        return self.dot(point: self);
    }
    
    func norm2() -> CGFloat {
        return sqrt(self.norm());
    }
    
    func d2( point:Point3D) -> CGFloat{
        let sub: Point3D = Point3D(x: self.x - point.x, y: self.y - point.y, z: self.z - point.z);
        return sub.norm2( )
    }
    
    func sub( point:Point3D) -> Point3D {
        let  sub:Point3D = Point3D(x:self.x - point.x, y: self.y - point.y, z: self.z - point.z)
        return sub;
    }
    
    func d(  point:Point3D) ->CGFloat {
        return self.sub( point: point).norm()
    }
    
    func add( scalar:CGFloat) -> Point3D {
        var newv:Point3D = Point3D(x: 0,y: 0,z: 0);
        newv.x = self.x + scalar;
        newv.y = self.y + scalar;
        newv.z = self.z + scalar;
        return newv;
    }
    
    func mul( point:Point3D) -> Point3D {
        var newv:Point3D = Point3D(x: 0,y: 0,z: 0);
        newv.x = self.x * point.x;
        newv.y = self.y * point.y;
        newv.z = self.z * point.z;
        return newv;
    }
}

//
//Point3D to3D(Point2D point) {
//    Point3D  u;    // segment direction vector
//    u.x = point.x;
//    u.y = point.y;
//    u.z = 0;
//    return u;
//}
//
//Point2D to2D( point) {
//    Point2D  u;    // segment direction vector
//    u.x = point.x;
//    u.y = point.y;
//    return u;
//}


//TODO: https://github.com/airbnb/lottie-ios/blob/master/lottie-swift/src/Private/Utility/Extensions/MathKit.swift
/**
 * CGAffineTransform
 *
 * var a = CGAffineTransformMakeRotation(45.0 * M_PI / 180.0)
 * var b = CGPointMake(30.0, 43.3)
 */

/**
 * ...
 * a + b
 */
func + (left: CGAffineTransform, right: CGPoint) -> CGAffineTransform {
    return left.translatedBy(x: right.x, y: right.y)
}

/**
 * ...
 * a += b
 */
func += (left: inout CGAffineTransform, right: CGPoint) {
    left = left + right
}

/**
 * ...
 * a - b
 */
func - (left: CGAffineTransform, right: CGPoint) -> CGAffineTransform {
    return left.translatedBy(x: -right.x, y: -right.y)
}

/**
 * ...
 * a -= b
 */
func -= (left: inout CGAffineTransform, right: CGPoint) {
    left = left - right
}

/**
 * ...
 * a * b
 */
func * (left: CGAffineTransform, right: CGPoint) -> CGAffineTransform {
    return left.scaledBy(x: right.x, y: right.y)
}

/**
 * ...
 * a *= b
 */
func *= (left: inout CGAffineTransform, right: CGPoint) {
    left = left * right
}

/**
 * Multiply transformation with CGPoint
 */
func * (left: CGAffineTransform, right: CGPoint) -> CGPoint {
    return CGPoint(
        x: left.a * right.x + left.b * right.y + left.tx,
        y: left.c * right.x + left.d * right.y + left.ty
    )
}

/**
 * Multiply transformation with CGSize
 */
func * (left: CGAffineTransform, right: CGSize) -> CGSize {
    return CGSize(
        width: left.a * right.width + left.b * right.height + left.tx,
        height: left.c * right.width + left.d * right.height + left.ty
    )
}

/**
 * Multiply transformation with CGRect
 * Only scale and translation operations are meaningful
 */
func * (left: CGAffineTransform, right: CGRect) -> CGRect {
    var point1 = CGPoint(x: right.origin.x, y: right.origin.y)
    var point2 = CGPoint(x: right.maxX, y: right.maxY)
    
    point1 = left * point1
    point2 = left * point2
    
    return CGRect(x: point1.x, y: point1.y, width: point2.x - point1.x, height: point2.y - point1.y)
}

/**
 * Rotation operator
 */
infix operator *^: MultiplicationPrecedence

/**
 * Rotate transformation
 *
 * var transform = CGAffineTransformMakeTranslation(100, 120)
 * transform = transform *^ (45.0 * M_PI / 180.0)
 */
func *^ (left: CGAffineTransform, right: CGFloat) -> CGAffineTransform {
    return left.rotated(by: right)
}

/**
 * Invert transformation
 *
 * var transform = CGAffineTransformMakeRotation(127.0 * M_PI / 180.0)
 * transform = ~transform
 */
prefix func ~ (left: CGAffineTransform) -> CGAffineTransform {
    return left.inverted()
}

/**
 * CGPoint
 *
 * var a = CGPointMake(13.5, -34.2)
 * var b = CGPointMake(8.9, 22.4)
 * ...
 */

/**
 * ...
 * a + b
 */
func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

/**
 * ...
 * a += b
 */
func += (left: inout CGPoint, right: CGPoint) {
    left = left + right
}

/**
 * ...
 * a -= b
 */
func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

/**
 * ...
 * a -= b
 */
func -= (left: inout CGPoint, right: CGPoint) {
    left = left - right
}

/**
 * ...
 * a * b
 */
func * (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x * right.x, y: left.y * right.y)
}

/**
 * ...
 * a *= b
 */
func *= (left: inout CGPoint, right: CGPoint) {
    left = left * right
}

/**
 * ...
 * a / b
 */
func / (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x / right.x, y: left.y / right.y)
}

/**
 * ...
 * a /= b
 */
func /= (left: inout CGPoint, right: CGPoint) {
    left = left / right
}

/**
 * ...
 * a * 10.4
 */
func * (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x * right, y: left.y * right)
}

/**
 * ...
 * a *= 10.4
 */
func *= (left: inout CGPoint, right: CGFloat) {
    left = left * right
}

/**
 * ...
 * a / 10.4
 */
func / (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x / right, y: left.y / right)
}

/**
 * ...
 * a /= 10.4
 */
func /= (left: inout CGPoint, right: CGFloat) {
    left = left / right
}

/**
 * var c = CGSizeMake(20.4, 75.8)
 * ...
 */

/**
 * ...
 * a + c
 */
func + (left: CGPoint, right: CGSize) -> CGPoint {
    return CGPoint(x: left.x + right.width, y: left.y + right.height)
}

/**
 * ...
 * a += c
 */
func += (left: inout CGPoint, right: CGSize) {
    left = left + right
}

/**
 * ...
 * a - c
 */
func - (left: CGPoint, right: CGSize) -> CGPoint {
    return CGPoint(x: left.x - right.width, y: left.y - right.height)
}

/**
 * ...
 * a -= c
 */
func -= (left: inout CGPoint, right: CGSize) {
    left = left - right
}

/**
 * ...
 * a * c
 */
func * (left: CGPoint, right: CGSize) -> CGPoint {
    return CGPoint(x: left.x * right.width, y: left.y * right.height)
}

/**
 * ...
 * a *= c
 */
func *= (left: inout CGPoint, right: CGSize) {
    left = left * right
}

/**
 * ...
 * a / c
 */
func / (left: CGPoint, right: CGSize) -> CGPoint {
    return CGPoint(x: left.x / right.width, y: left.y / right.height)
}

/**
 * ...
 * a /= c
 */
func /= (left: inout CGPoint, right: CGSize) {
    left = left / right
}

/**
 * ...
 * -a
 */
prefix func - (left: CGPoint) -> CGPoint {
    return CGPoint(x: -left.x, y: -left.y)
}


extension CGPoint {
    /**
     * Get point by rounding to nearest integer value
     */
    var integerPoint: CGPoint {
        return CGPoint(
            x: CGFloat(Int(self.x >= 0.0 ? self.x + 0.5 : self.x - 0.5)),
            y: CGFloat(Int(self.y >= 0.0 ? self.y + 0.5 : self.y - 0.5))
        )
    }
}

/**
 * Get minimum x and y values of multiple points
 */
func min(a: CGPoint, b: CGPoint, rest: CGPoint...) -> CGPoint {
    var p = CGPoint(x: min(a.x, b.x), y: min(a.y, b.y))
    
    for point in rest {
        p.x = min(p.x, point.x)
        p.y = min(p.y, point.y)
    }
    
    return p
}

/**
 * Get maximum x and y values of multiple points
 */
func max(a: CGPoint, b: CGPoint, rest: CGPoint...) -> CGPoint {
    var p = CGPoint(x: max(a.x, b.x), y: max(a.y, b.y))
    
    for point in rest {
        p.x = max(p.x, point.x)
        p.y = max(p.y, point.y)
    }
    
    return p
}

/**
 * CGSize
 */

/**
 * var a = CGSizeMake(8.9, 14.5)
 * var b = CGSizeMake(20.4, 75.8)
 * ...
 */

/**
 * ...
 * a + b
 */
func + (left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width + right.width, height: left.height + right.height)
}

/**
 * ...
 * a += b
 */
func += (left: inout CGSize, right: CGSize) {
    left = left + right
}

/**
 * ...
 * a - b
 */
func - (left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width - right.width, height: left.height - right.height)
}

/**
 * ...
 * a -= b
 */
func -= (left: inout CGSize, right: CGSize) {
    left = left - right
}

/**
 * ...
 * a * b
 */
func * (left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width * right.width, height: left.height * right.height)
}

/**
 * ...
 * a *= b
 */
func *= (left: inout CGSize, right: CGSize) {
    left = left * right
}

/**
 * ...
 * a / b
 */
func / (left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width / right.width, height: left.height / right.height)
}

/**
 * ...
 * a /= b
 */
func /= (left: inout CGSize, right: CGSize) {
    left = left / right
}

/**
 * var c = CGPointMake(-3.5, -17.6)
 * ...
 */

/**
 * ...
 * a + c
 */
func + (left: CGSize, right: CGPoint) -> CGSize {
    return CGSize(width: left.width + right.x, height: left.height + right.y)
}

/**
 * ...
 * a += c
 */
func += (left: inout CGSize, right: CGPoint) {
    left = left + right
}

/**
 * ...
 * a - c
 */
func - (left: CGSize, right: CGPoint) -> CGSize {
    return CGSize(width: left.width - right.x, height: left.height - right.y)
}

/**
 * ...
 * a -= c
 */
func -= (left: inout CGSize, right: CGPoint) {
    left = left - right
}

/**
 * ...
 * a * c
 */
func * (left: CGSize, right: CGPoint) -> CGSize {
    return CGSize(width: left.width * right.x, height: left.height * right.y)
}

/**
 * ...
 * a *= c
 */
func *= (left: inout CGSize, right: CGPoint) {
    left = left * right
}

/**
 * ...
 * a / c
 */
func / (left: CGSize, right: CGPoint) -> CGSize {
    return CGSize(width: left.width / right.x, height: left.height / right.y)
}

/**
 * ...
 * a /= c
 */
func /= (left: inout CGSize, right: CGPoint) {
    left = left / right
}

/**
 * ...
 * a * 4.6
 */
func * (left: CGSize, right: CGFloat) -> CGSize {
    return CGSize(width: left.width * right, height: left.height * right)
}

/**
 * ...
 * a *= 4.6
 */
func *= (left: inout CGSize, right: CGFloat) {
    left = left * right
}

/**
 * CGRect
 *
 * var a = CGRectMake(30.4, 58.6, 20.3, 78.3)
 * var b = CGPointMake(-16.7, 40.5)
 * ...
 */

/**
 * ...
 * a + b
 */
func + (left: CGRect, right: CGPoint) -> CGRect {
    return CGRect(x: left.origin.x + right.x, y: left.origin.y + right.y, width: left.size.width, height: left.size.height)
}

/**
 * ...
 * a += b
 */
func += (left: inout CGRect, right: CGPoint) {
    left = left + right
}

/**
 * ...
 * a - b
 */
func - (left: CGRect, right: CGPoint) -> CGRect {
    return CGRect(x: left.origin.x - right.x, y: left.origin.y - right.y, width: left.size.width, height: left.size.height)
}

/**
 * ...
 * a -= b
 */
func -= (left: inout CGRect, right: CGPoint) {
    left = left - right
}

/**
 * ...
 * a * 2.5
 */
func * (left: CGRect, right: CGFloat) -> CGRect {
    return CGRect(x: left.origin.x * right, y: left.origin.y * right, width: left.size.width * right, height: left.size.height * right)
}

/**
 * ...
 * a *= 2.5
 */
func *= (left: inout CGRect, right: CGFloat) {
    left = left * right
}

/**
 * ...
 * a / 4.0
 */
func / (left: CGRect, right: CGFloat) -> CGRect {
    return CGRect(x: left.origin.x / right, y: left.origin.y / right, width: left.size.width / right, height: left.size.height / right)
}

/**
 * ...
 * a /= 4.0
 */
func /= (left: inout CGRect, right: CGFloat) {
    left = left / right
}

extension CGRect {
    /**
     * Extend CGRect by CGPoint
     */
    mutating func union(withPoint: CGPoint) {
        if withPoint.x < self.origin.x { self.size.width += self.origin.x - withPoint.x; self.origin.x = withPoint.x }
        if withPoint.y < self.origin.y { self.size.height += self.origin.y - withPoint.y; self.origin.y = withPoint.y }
        if withPoint.x > self.origin.x + self.size.width { self.size.width = withPoint.x - self.origin.x }
        if withPoint.y > self.origin.y + self.size.height { self.size.height = withPoint.y - self.origin.y; }
    }
    
    /**
     * Get end point of CGRect
     */
    func maxPoint() -> CGPoint {
        return CGPoint(x: self.origin.x + self.size.width, y: self.origin.y + self.size.height)
    }
}


extension CGPoint {
    func translate(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + x, y: self.y + y)
    }
    func translateX(_ x: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + x, y: self.y)
    }
    func translateY(_ y: CGFloat) -> CGPoint {
        return CGPoint(x: self.x, y: self.y + y)
    }
    func invertY() -> CGPoint {
        return CGPoint(x: self.x, y: -self.y)
    }
    func xAxis() -> CGPoint {
        return CGPoint(x: 0, y: self.y)
    }
    func yAxis() -> CGPoint {
        return CGPoint(x: self.x, y: 0)
    }
    func add(a: CGPoint) -> CGPoint {
        return CGPoint(x: self.x + a.x, y: self.y + a.y)
    }
    func addScalar(scalar: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + scalar, y: self.y + scalar)
    }
    func sub(a: CGPoint) -> CGPoint {
        return CGPoint(x: self.x - a.x, y: self.y - a.y)
    }
    func subScalar(a: CGFloat) -> CGPoint {
        return CGPoint(x: self.x - a, y: self.y - a)
    }
    func deltaTo(a: CGPoint) -> CGPoint {
        return CGPoint(x: self.x - a.x, y: self.y - a.y)
    }
    func multiplyBy(value: CGFloat) -> CGPoint {
        return CGPoint(x: self.x * value, y: self.y * value)
    }
    func divByScalar(value: CGFloat) -> CGPoint {
        return CGPoint(x: self.x / value, y: self.y / value)
    }
    func length() -> CGFloat {
        return CGFloat(sqrt(CDouble(self.x*self.x + self.y*self.y)))
    }
    func normalize() -> CGPoint {
        let l = self.length()
        return CGPoint(x: self.x / l, y: self.y / l)
    }
    static func fromString(_ string: String) -> CGPoint {
        var s = string.replacingOccurrences(of: "{", with: "")
        s = s.replacingOccurrences(of: "}", with: "")
        s = s.replacingOccurrences(of: " ", with: "")
        let x = NSString(string: s.components(separatedBy: ",").first! as String).doubleValue
        let y = NSString(string: s.components(separatedBy: ",").last! as String).doubleValue
        return CGPoint(x: CGFloat(x), y: CGFloat(y))
    }
    
    /// Get the mid point of the receiver with another passed point.
    ///
    /// - Parameter p2: other point.
    /// - Returns: mid point.
    func midPointForPointsTo(_ p2: CGPoint) -> CGPoint {
        return CGPoint(x: (x + p2.x) / 2, y: (y + p2.y) / 2)
    }
    /// Control point to another point from receiver.
    ///
    /// - Parameter p2: other point.
    /// - Returns: control point for quad curve.
    func controlPointToPoint(_ point2: CGPoint) -> CGPoint {
        var controlPoint = self.midPointForPointsTo(point2)
        let  diffY = abs(point2.y - controlPoint.y)
        if self.y < point2.y {
            controlPoint.y += diffY
        } else if self.y > point2.y {
            controlPoint.y -= diffY
        }
        return controlPoint
    }
    public func equalsTo(_ compare: Self) -> Bool {
        return self.x == compare.x && self.y == compare.y
    }
    public func distanceFrom(_ otherPoint: Self) -> CGFloat {
        let dx = self.x - otherPoint.x
        let dy = self.y - otherPoint.y
        return (dx * dx) + (dy * dy)
    }
    public func distance(from lhs: CGPoint) -> CGFloat {
        return hypot(lhs.x.distance(to: self.x), lhs.y.distance(to: self.y))
    }
    public func distanceToSegment(_ p1:  CGPoint, _ p2: CGPoint) -> Float {
        var x = p1.x
        var y = p1.y
        var dx = p2.x - x
        var dy = p2.y - y
        
        if dx != 0 || dy != 0 {
            let t = ((self.x - x) * dx + (self.y - y) * dy) / (dx * dx + dy * dy)
            if t > 1 {
                x = p2.x
                y = p2.y
            } else if t > 0 {
                x += dx * t
                y += dy * t
            }
        }
        
        dx = self.x - x
        dy = self.y - y
        
        return Float(dx * dx + dy * dy)
    }
    func distanceToLine(from linePoint1: CGPoint, to linePoint2: CGPoint) -> CGFloat {
        let dx = linePoint2.x - linePoint1.x
        let dy = linePoint2.y - linePoint1.y
        
        let dividend = abs(dy * self.x - dx * self.y - linePoint1.x * linePoint2.y + linePoint2.x * linePoint1.y)
        let divisor = sqrt(dx * dx + dy * dy)
        
        return dividend / divisor
    }
    /**
     Averages the point with another.
     - parameter point: The point to average with.
     - returns: A point with an x and y equal to the average of this and the given point's x and y.
     */
    func average(with point: CGPoint) -> CGPoint {
        return CGPoint(x: (x + point.x) * 0.5, y: (y + point.y) * 0.5)
    }
    
    /**
     Calculates the difference in x and y between 2 points.
     - parameter point: The point to calculate the difference to.
     - returns: A point with an x and y equal to the difference between this and the given point's x and y.
     */
    func differential(to point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x - x, y: point.y - y)
    }
    
    /**
     Calculates the distance between two points.
     - parameter point: the point to calculate the distance to.
     - returns: A CGFloat of the distance between the points.
     */
    func distance(to point: CGPoint) -> CGFloat {
        return differential(to: point).hypotenuse
    }
    
    /**
     Calculates the hypotenuse of the x and y component of a point.
     - returns: A CGFloat for the hypotenuse of the point.
     */
    var hypotenuse: CGFloat {
        return sqrt(x * x + y * y)
    }
}

public extension CGPoint {
    
    /// - returns: A `CGVector` with dx: x and dy: y.
    var vector: CGVector {
        return CGVector(dx: x, dy: y)
    }
    
    /// - returns: A `CGPoint` with rounded x and y values.
    var rounded: CGPoint {
        return CGPoint(x: round(x), y: round(y))
    }
    
    /// - returns: The Euclidean distance from self to the given point.
    //    public func distance(to point: CGPoint) -> CGFloat {
    //        return (point - self).magnitude
    //    }
    
    /// Constrains the x and y value to within the provided rect.
    //    public func clipped(to rect: CGRect) -> CGPoint {
    //        return CGPoint(x: x.clipped(rect.minX, rect.maxX),
    //            y: y.clipped(rect.minY, rect.maxY))
    //    }
    
    /// - returns: The relative position inside the provided rect.
    func position(in rect: CGRect) -> CGPoint {
        return CGPoint(x: x - rect.origin.x,
                       y: y - rect.origin.y)
    }
    
    /// - returns: The position inside the provided rect,
    /// where horizontal and vertical position are normalized
    /// (i.e. mapped to 0-1 range).
    func normalizedPosition(in rect: CGRect) -> CGPoint {
        let p = position(in: rect)
        return CGPoint(x: (1.0 / rect.width) * p.x,
                       y: (1.0 / rect.width) * p.y)
    }
    
    /// - returns: True if the line contains the point.
     func isAt(line: [CGPoint]) -> Bool {
        return line.contains(self)
    }
}
// swiftlint:enable identifier_name shorthand_operator
