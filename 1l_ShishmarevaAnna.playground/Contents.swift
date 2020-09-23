//Lesson1
import  Foundation

//Первое задание
func findD(a:Double,b:Double,c:Double)->Double{
    return pow(b, 2)-4*a*c
}
func findX(a:Double,b:Double,d:Double)->Double{
    if d>=0{
        return (-b+sqrt(d))/(2*a)
    }
    else{
        return (-b-sqrt(-1*d))/(2*a)
    }
}
func solveEquation(a:Double,b:Double,c:Double){
    print("Решение уровнения: \(a)*x^2+\(b)*x+\(c)")
    var d:Double
    d=findD(a: a, b: b, c: c)
    if d<0{
        print("Корней нет!")
    }
    if d==0{
        print("Корень один = \(findX(a: a, b: b, d: d))")
    }
    if d>0{
        print("Корня два: \(findX(a: a, b: b, d: d))")
        print("           \(findX(a: a, b: b, d: -d))")
    }
}
solveEquation(a: 2,b: 2,c: 3)
solveEquation(a: 1,b: 2,c: 1)
solveEquation(a: 1,b: 4,c: 1)

//Второе задание
func findArea(a:Double,b:Double)->Double{
    return a*b/2
}
func findHypotenuse(a:Double,b:Double)->Double{
    return sqrt(pow(a, 2)+pow(b, 2))
}
func findPerimeter(a:Double,b:Double)->Double{
    return a+b+findHypotenuse(a: a, b: b)
}
func printMessage(a:Double,b:Double)->String{
    return "Треугольник с катетами \(a) и \(b):"
}
func findTriagleParameters(a:Double,b:Double){
    if (a<=0||b<=0){
        print("\(printMessage(a: a, b: b)) не существует")
    }
    else{
        print(printMessage(a: a, b: b))
        print("Площадь = \(findArea(a: a, b: b))")
        print("Периметр = \(findPerimeter(a: a, b: b))")
        print("Гипотенуза = \(findHypotenuse(a: a, b: b))")
    }
    
}
findTriagleParameters(a: 2, b: 2)
findTriagleParameters(a: 1, b: 5)
findTriagleParameters(a: 5, b: 1)
findTriagleParameters(a: 0, b: 2)

//Третье задание
func findDepositAmount(depoisit:Double,procent:Double)->Double{
    if (depoisit>0&&procent>0){
        var sum:Double = depoisit
        for _ in 0...4 {
            sum=sum*(1+procent/100)
        }
        return sum
    }
    else{
        return 0
    }
}

print("Сумма вклада = \(findDepositAmount(depoisit: 100, procent: 5))")
print("Сумма вклада = \(findDepositAmount(depoisit: -100, procent: 5))")
print("Сумма вклада = \(findDepositAmount(depoisit: 100, procent: -5))")
