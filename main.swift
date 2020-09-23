//
//  main.swift
//  1l_ShishmarevaAnna
//
//  Created by Анна on 23.09.2020.
//  Третье задание

import Foundation

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
print("Введите сумму вклада:")
let d=readLine()
print("Введите процент вклада:")
let p=readLine()
var deposit=Double(d!)
var procent=Double(p!)

print("Сумма вклада = \(findDepositAmount(depoisit: deposit!, procent: procent!))")

