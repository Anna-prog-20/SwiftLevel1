import Cocoa

enum VariantError: Error {
    case notEquation(b: Double, c: Double)
    case allZero
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .unknown:
            return "Неизвестная ошибка!"
        case .allZero:
            return "Вы ввели все аргументы равные 0 - уравнение не существует!"
        case .notEquation(b: let b, c: let c):
            return "Уравнение \(b)*x + \(c) не является квадратным!"
        }
    }
}

class Equation {
    var a: Double
    var b: Double
    var c: Double
    var d: Double {
        get {
            return pow(b, 2) - 4*a*c
        }
    }
    
    init(a: Double, b: Double, c: Double) {
        self.a = a
        self.b = b
        self.c = c
    }
    
    private func findX(d: Double) -> Double {
        if d >= 0 {
            return round(100*(-b + sqrt(d))/(2*a))/100
        }
        else{
            return round(100*(-b - sqrt(-1*d))/(2*a))/100
        }
    }
    
    var checkA0: (Double, Double, Double) -> Bool = {
        return ($0 == 0 && $1 != 0 && $2 != 0)
    }
    
    var checkA0B0: (Double, Double, Double) -> Bool = {
        return ($0 == 0 && $1 == 0 && $2 != 0)
    }
    
    var checkA0C0: (Double, Double, Double) -> Bool = {
        return ($0 == 0 && $1 != 0 && $2 != 0)
    }
    
    var checkB0: (Double, Double, Double) -> Bool = {
        return ($0 != 0 && $1 == 0 && $2 != 0)
    }
    
    var checkB0C0: (Double, Double, Double) -> Bool = {
        return ($0 != 0 && $1 == 0 && $2 == 0)
    }
    
    var checkC0: (Double, Double, Double) -> Bool = {
        return ($0 != 0 && $1 != 0 && $2 == 0)
    }
    
    var checkAllNotZero: (Double, Double, Double) -> Bool = {
        return $0 != 0 && $1 != 0 && $2 != 0
    }
    
    func solveEquation() -> (void: Void?, error: VariantError?) {
        
        if checkA0(a, b, c) || checkA0B0(a, b, c){
            return (nil, .notEquation(b: b, c: c))
        }
        
        guard checkAllNotZero(a, b, c) else {
            return (nil, .allZero)
        }
    
        if d < 0{
            return (print("Корней нет!"), nil)
        }
        if d == 0{
            return (print("Корень один = \(findX(d: d))"), nil)
        }
        if d > 0{
            return (print("""
                Корня два: \(findX(d: d))
                           \(findX(d: -d))
                """), nil)
        }
        return (nil, .unknown)
    }
}

extension Equation: CustomStringConvertible {
    var description: String {
        var str = ""
        let check: Bool = true
        switch check {
        case checkA0(a, b, c):
            str = "Решение уровнения: \(b)*x+\(c)"
        case checkA0B0(a, b, c):
            str = "Решение уровнения: \(c)"
        case checkA0C0(a, b, c):
            str = "Решение уровнения: \(b)*x"
        case checkB0(a, b, c):
            str = "Решение уровнения: \(a)*x^2+\(c)"
        case checkB0C0(a, b, c):
            str = "Решение уровнения: \(a)*x^2"
        case checkB0C0(a, b, c):
            str = "Решение уровнения: \(a)*x^2"
        case !checkAllNotZero(a, b, c):
            str = "Решение уровнения: пустое уравнение"
        default:
            str = "Решение уровнения: \(a)*x^2+\(b)*x+\(c)"
        }
//        if checkAllNotZero(a, b, c) {
//            str = "Решение уровнения: \(a)*x^2+\(b)*x+\(c)"
//        } else if checkA0(a, b, c) {
//            str = "Решение уровнения: \(b)*x+\(c)"
//        }
        return str
    }
}

print("********Error***********")
let equations: [Equation] = [Equation(a: 2, b: 2, c: 3),
                             Equation(a: 1,b: 2,c: 1),
                             Equation(a: 1,b: 4,c: 1),
                             Equation(a: 0,b: 4,c: 1),
                             Equation(a: 0,b: 0,c: 0)]

for equation in equations {
    print(equation)
    if let equationTest = equation.solveEquation().void {
        equationTest
    }
    else if let errorTest = equation.solveEquation().error {
        print("Произошла ошибка: \(errorTest.localizedDescription)")
    }
}

extension Equation {
    func solveEquationTryCatch() throws {
        
        if checkA0(a, b, c) || checkA0B0(a, b, c) {
            throw VariantError.notEquation(b: b, c: c)
        }
        
        guard checkAllNotZero(a, b, c) else {
            throw VariantError.allZero
        }
    
        if d < 0{
            print("Корней нет!")
        }
        if d == 0{
            print("Корень один = \(findX(d: d))")
        }
        if d > 0{
            print("""
                Корня два: \(findX(d: d))
                           \(findX(d: -d))
                """)
        }
    }
}

print("********try/catch***********")
for equation in equations {
    print(equation)
    do {
        try equation.solveEquationTryCatch()
    }
    catch let errorTest as VariantError {
        print("Произошла ошибка: \(errorTest.localizedDescription)")
    }
    
}

