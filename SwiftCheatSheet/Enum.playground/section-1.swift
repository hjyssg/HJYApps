enum CompassPoint {
    case North
    case South
    case East
    case West
}
var directionToHead = CompassPoint.West
//间接告诉swift，directionToHead 是CompassPoint type，改的时候可以省去CompassPoint直接打“.”
directionToHead = .East

//swift允许每个case有特定的数值
enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}
var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)
productBarcode = .QRCode("ABCDEFGHIJKLMNOP")

//Use switch to access the value
switch productBarcode {
    case .UPCA(let numberSystem, let manufacturer, let product, let check):
        println("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
        break
    case .QRCode(let productCode):
        println("QR code: \(productCode).")
        break
}

//enum with string value
enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}
