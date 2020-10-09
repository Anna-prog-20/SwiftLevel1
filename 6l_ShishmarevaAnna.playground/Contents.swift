import Cocoa

protocol ObjectQueueProtocol {
    var name: String { get set}
    var age: Int { get set}
    var statusHonesty: Honesty {get set}
    var className: String {get}
}

class Cat: ObjectQueueProtocol {
    var name: String = "Мурзик"
    var age: Int
    var statusHonesty: Honesty
    var className = "Cat"
    
    init?(name: String, age: Int = 1) {
        guard age > 0 else {
            return nil
        }
        self.name = name
        self.age = age
        self.statusHonesty = .yes
    }
}

extension Cat: CustomStringConvertible {
    var description: String {
        return """
            ********Семейство кошачьих*********
            Кличка: \(name)
            Возраст: \(age == 0 ? "не известен" : "\(age)")
            """
    }
}

enum Gender: String {
    case man = "мужчина"
    case woman = "женщина"
}

enum Honesty: String {
    case yes = "честный"
    case no = "наглый"
}

class People: ObjectQueueProtocol {
    var name: String = "Вася"
    var age: Int = 14
    var gender: Gender = .man
    var statusHonesty: Honesty = .yes
    
    var className = "People"
    
    init?(name: String, age: Int = 14, gender: Gender, statusHonesty: Honesty = .yes) {
        guard age > 0 else {
            return nil
        }
        self.name = name
        self.age = age
        self.gender = gender
        self.statusHonesty = statusHonesty
    }
}

extension People: CustomStringConvertible {
    var description: String {
        return """
            ********Человек*********
            Имя: \(name)
            Возраст: \(age == 0 ? "не известен" : "\(age)")
            Пол: \(gender.rawValue)
            Статус честности: \(statusHonesty.rawValue)
            """
    }
}

struct Queue <T: ObjectQueueProtocol> {
    private var elements: [T] = []
    
    func countQueue() -> Int {
        return elements.count
    }
    
    mutating func push(_ element: T) {
        elements.append(element)
    }
    
    mutating func push(_ element: T, index: Int) {
        if element.statusHonesty == .no {
            print("\(element.name), как вам не стыдно, вы прошли вне очереди!")
            elements.insert(element, at: index)
        }
        else {
            print("\(element.name) Вы очень честны, чтоб встать \(index+1)-ым по порядку, поэтому вы стоите в конце очереди!")
            elements.append(element)
        }
    }
    
    mutating func pop() -> T? {
        guard elements.count > 0 else { return nil }
        print("\(elements[0].name) - окончание обслуживания!")
        return elements.removeFirst()
    }
    
    mutating func pop(index: Int) -> T? {
        guard elements.count > 0 else { return nil }
        print("\(elements[index].name) - не дождались своей очереди!")
        return elements.remove(at: index)
    }
 
    let quest: (T, Any) -> Bool = {
        $0.className == "\($1.self)"
    }
    
    func filter(questType: Any, predicate: (T, Any) -> Bool ) -> [T] {
        print("")
        print("=======Фильтр \(questType)=======")
        var tmpArray = [T]()
        for element in elements {
            if predicate(element, questType) {
                tmpArray.append(element)
            }
        }
        return tmpArray
    }
    
    func sortedAge() -> [T] {
        print("")
        print("=======Сортировка по возрасту=======")
        var tmpArray = elements
        tmpArray.sort {$0.age < $1.age}
        return tmpArray
    }
}

extension Queue {
    subscript(elements: Int ...) -> Int? {
        print("")
        print("=======Суммируем возраст=======")
        var sumAge = 0
        for index in elements {
            if index >= 0 && index < self.elements.count {
                sumAge += self.elements[Int(index)].age
            }
            else {
                return nil
            }
        }
        return sumAge
    }
}

enum ObjectQueue: ObjectQueueProtocol {
    case cat(Cat)
    case people(People)
    
    var className: String {
        get {
            switch self {
            case .cat( _):
                return "Cat"
            case .people( _):
                return "People"
            }
        }
    }
    var name: String {
        get {
            switch self {
            case .cat(let cat):
                return cat.name
            case .people(let people):
                return people.name
            }
        }
        set {
            switch self {
            case .cat(let cat):
                cat.name = newValue
            case .people(let people):
                people.name = newValue
            }
        }
    }
    
    var age: Int {
        get {
            switch self {
            case .cat(let cat):
                return cat.age
            case .people(let people):
                return people.age
            }
        }
        set {
            switch self {
            case .cat(let cat):
                cat.age = newValue
            case .people(let people):
                people.age = newValue
            }
        }
    }
    
    var statusHonesty: Honesty {
        get {
            switch self {
            case .cat(let cat):
                return cat.statusHonesty
            case .people(let people):
                return people.statusHonesty
            }
        }
        set {
            switch self {
            case .cat(let cat):
                cat.statusHonesty = newValue
            case .people(let people):
                people.statusHonesty = newValue
            }
        }
    }
}

func printInfo(array: [ObjectQueueProtocol]) {
    for i in 0...array.count-1 {
        print(array[i])
    }
}

var queue = Queue<ObjectQueue>()

queue.push(.cat(Cat(name: "Муська")!))
queue.push(.people(People(name: "Вова", age: 20, gender: .man, statusHonesty: .yes)!))
queue.push(.people(People(name: "Света",age: 70, gender: .woman, statusHonesty: .yes)!),index: 5)
queue.push(.people(People(name: "Фудя",age: 16, gender: .man, statusHonesty: .no)!),index: 1)
queue.push(.cat(Cat(name: "Барсик", age: 4)!))

queue.pop()

printInfo(array: queue.filter(questType: People.self, predicate: queue.quest))

printInfo(array: queue.sortedAge())

print(queue[-9, 5, 1])

print(queue[2, 1, 3])
