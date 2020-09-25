import Foundation

//1. Написать функцию, котороая определяет, четное число или нет

func determineDivisionByNumber(number:Int, numberDivision:Int)->Bool{
    if (number%numberDivision == 0)&&(numberDivision != 0) {
        return true
    }
    else {
        return false
    }
}

func checkEvenNumber(number:Int){
    if (determineDivisionByNumber(number: number, numberDivision: 2)) {
        print("Число \(number) четное")
    }
    else {
        print("Число \(number)  не четное")
    }
}

checkEvenNumber(number: 20)
checkEvenNumber(number: 23)
checkEvenNumber(number: 0)

print("==========")

//2. Написать функцию, которая определяет, делится ли число без остатка на 3.

func checkDivisionByThree(number:Int){
    if (determineDivisionByNumber(number: number, numberDivision: 3)) {
        print("Число \(number) делится на 3 без остатка")
    }
    else {
        print("Число \(number)  не делится на 3 без остатка")
    }
}

checkDivisionByThree(number: 30)
checkDivisionByThree(number: 40)
checkDivisionByThree(number: 33)

print("==========")

//3. Создать возрастающий массив из 100 чисел.

func createArray(_ n:Int,_ firstNumber:Int) ->[Int]{
    var array: [Int]=[]
    for i in 0...n-1 {
        array.append(firstNumber+i)
    }
    return array
}

var array=createArray(100,1)
print(array)

print("==========")

//4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.

func changeArray(_ array: inout [Int])->[Int]{
    for element in array where ((determineDivisionByNumber(number: element, numberDivision: 2)||(determineDivisionByNumber(number: element, numberDivision: 3)==false))) {
        array.remove(at: array.firstIndex(of: element) ?? 0)
    }
    return array
}

print(changeArray(&array))

print("==========")

//5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов.
//Числа Фибоначчи определяются соотношениями Fn=Fn-1 + Fn-2.

func numberFibonachi(f1:Double, f2:Double)->Double{
    return f2+f1
}

func addNumberFibonachi(_ array: inout [Double]){
    array.append(numberFibonachi(f1: array[array.count-2], f2: array[array.count-1]))
}

var arrayFibonachi: [Double]=[2,6,4]

for _ in (1...50){
    addNumberFibonachi(&arrayFibonachi)
}

print(arrayFibonachi)

print("==========")

//6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги:

func methodErutosfen(){
    //a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).

    let n = 100
    var arrayErutosfen = createArray(n,2)
    print(arrayErutosfen)

    //b. Пусть переменная p изначально равна двум — первому простому числу.
    var p = arrayErutosfen[0]

    while (p != arrayErutosfen[arrayErutosfen.count-1]){
        //c. Зачеркнуть в списке числа от 2 + p до n, считая шагом p..

        for i in stride(from:2+p, through:n, by:p){
            arrayErutosfen.remove(at: arrayErutosfen.firstIndex(of: i) ?? 0)
        }
        
        //d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.

        for element in arrayErutosfen where element>p{
            p = element
            break
        }

        //e. Повторять шаги c и d, пока возможно.
    }

    print(arrayErutosfen)
}

methodErutosfen()
