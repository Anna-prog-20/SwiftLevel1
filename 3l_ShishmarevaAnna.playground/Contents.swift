import Cocoa

enum EngineCondition:String{
    case start = "запущен"
    case stop = "остановлен"
    case notWork = "сломан"
}

enum WindowCondition: String{
    case open = "открыты"
    case close = "закрыты"
}

enum Action{
    case load
    case unload
}

enum ActionValume{
    case more
    case less
    case equals
}

struct SportCar{
    let model:String
    var yearManufacture:Int=0
    let trunkValume:Double!
    var engineCondition:EngineCondition = .stop
    var windowCondition:WindowCondition = .close
    var filledTrunkValume:Double=0.0
    
    mutating func setEnergineCondition(engineCondition:EngineCondition){
        print("Двигатель \(engineCondition.rawValue)...")
        self.engineCondition=engineCondition
    }
    
    mutating func setWindowCondition(windowCondition:WindowCondition){
        print("Окна \(windowCondition.rawValue)...")
        self.windowCondition=windowCondition
    }
    
    func check(valume:Double, trunkValume:Double=0)->ActionValume{
        let a = filledTrunkValume + valume
        var action:ActionValume
        if a > trunkValume{
            action = .more
        }
        else if a==0 {
            action = .equals
        }
        else {
            action = .less
        }
        if filledTrunkValume == 0.0 && a<0{
            action = .equals
        }
        return action
    }
        
    mutating func setFilledTrunkValume(action:Action, valume:Double){
        if valume>=0 {
            switch action {
            case .load:
                print("Пытаемся загрузить \(valume)...")
                if check(valume: valume,trunkValume: trunkValume)==ActionValume.more{
                    print("Извините, но загрузить возможно всего \(trunkValume-filledTrunkValume) единиц")
                }
                else if check(valume: valume,trunkValume: trunkValume)==ActionValume.equals {
                    print("Извините, но багажник заполнен!")
                }
                else {
                    self.filledTrunkValume+=valume
                    print("Загружаем в багажник... Теперь в багажнике \(filledTrunkValume) единиц")
                }
            case .unload:
                print("Пытаемся выгрузить \(valume)...")
                if check(valume: -valume)==ActionValume.less{
                    print("Извините, но выгрузить возможно всего \(filledTrunkValume) единиц")
                }
                else if check(valume: -valume)==ActionValume.equals {
                    print("Из багажника нечего выгружать!")
                }
                else {
                    self.filledTrunkValume-=valume
                    print("Выгружаем из багажника... Теперь в багажнике \(filledTrunkValume) единиц")
                }
            }
        }
        else{
            print("Не корректно введено значение!")
        }
    }
    
    func information(){
        print("********Легковой автомобиль*********")
        print("Модель: \(model)")
        print("Год выпуска: \(yearManufacture == 0 ? "не известен" : "\(self.yearManufacture)")")
        print("Объем багажника: \(trunkValume ?? 0 )")
        print("Двигатель: \(engineCondition.rawValue)")
        print("Окна: \(windowCondition.rawValue)")
        print("Заполненный объем багажника: \(filledTrunkValume)")
    }
    
    init?(model: String, yearManufacture: Int, trunkValume: Double, engineCondition: EngineCondition = .stop, windowCondition: WindowCondition = .close, filledTrunkValume: Double = 0){
        guard yearManufacture > 0 && trunkValume > 0 else { return nil }
        self.model = model
        self.yearManufacture = yearManufacture
        self.trunkValume = trunkValume
        self.engineCondition = engineCondition
        self.windowCondition = windowCondition
        self.filledTrunkValume = filledTrunkValume
    }
    
    init?(model: String, trunkValume: Double){
        guard trunkValume > 0 else { return nil }
        self.model = model
        self.trunkValume = trunkValume
    }
    
    init?(model: String, yearManufacture: Int, trunkValume: Double){
        guard yearManufacture > 0 && trunkValume > 0 else { return nil }
        self.model = model
        self.yearManufacture = yearManufacture
        self.trunkValume = trunkValume
    }
    
}

struct TrunkCar{
    let model:String
    var yearManufacture:Int=0
    var bodyValume:Double!
    var engineCondition:EngineCondition = .stop
    var windowCondition:WindowCondition = .close
    var filledBodyValume:Double=0.0
    
    mutating func setEnergineCondition(engineCondition:EngineCondition){
        print("Двигатель \(engineCondition.rawValue)...")
        self.engineCondition=engineCondition
    }
    
    mutating func setWindowCondition(windowCondition:WindowCondition){
        print("Окна \(windowCondition.rawValue)...")
        self.windowCondition=windowCondition
    }
    
    func check(valume:Double, bodyValume:Double=0)->ActionValume{
        let a = filledBodyValume + valume
        var action:ActionValume
        if a > bodyValume{
            action = .more
        }
        else if a==0 {
            action = .equals
        }
        else {
            action = .less
        }
        if filledBodyValume == 0.0 && a<0{
            action = .equals
        }
        return action
    }
        
    mutating func setFilledBodyValume(action:Action, valume:Double){
        if valume>=0&&bodyValume != 0&&bodyValume != nil {
            switch action {
            case .load:
                print("Пытаемся загрузить \(valume)...")
                if check(valume: valume,bodyValume: bodyValume)==ActionValume.more{
                    print("Извините, но загрузить возможно всего \(bodyValume-filledBodyValume) единиц")
                }
                else if check(valume: valume,bodyValume: bodyValume)==ActionValume.equals {
                    print("Извините, но кузов заполнен!")
                }
                else {
                    self.filledBodyValume+=valume
                    print("Загружаем в кузов... Теперь в кузове \(filledBodyValume) единиц")
                }
            case .unload:
                print("Пытаемся выгрузить \(valume)...")
                if check(valume: -valume)==ActionValume.less{
                    print("Извините, но выгрузить возможно всего \(filledBodyValume) единиц")
                }
                else if check(valume: -valume)==ActionValume.equals {
                    print("Из кузова нечего выгружать!")
                }
                else {
                    self.filledBodyValume-=valume
                    print("Выгружаем из кузова... Теперь в кузове \(filledBodyValume) единиц")
                }
            }
        }
        else{
            if valume<0 {
                print("Не корректно введено значение!")
            }
            else{
                print("У данного грузовика нет кузова!")
            }
        }
    }
    
    func information(){
        print("********Грузовик*********")
        print("Модель: \(model)")
        print("Год выпуска: \(yearManufacture == 0 ? "не известен" : "\(self.yearManufacture)")")
        print("Объем  кузова: \(bodyValume == 0.0||bodyValume == nil ? "отсутствует" : "\(self.bodyValume ?? 0)")")
        print("Двигатель: \(engineCondition.rawValue)")
        print("Окна: \(windowCondition.rawValue)")
        if bodyValume != 0.0||bodyValume != nil {
            print("Заполненный объем кузова: \(filledBodyValume)")
        }
    }
    
    init?(model: String, yearManufacture: Int, bodyValume: Double, engineCondition: EngineCondition = .stop, windowCondition: WindowCondition = .close, filledBodyValume: Double = 0){
        guard yearManufacture > 0 && bodyValume > 0 else { return nil }
        self.model = model
        self.yearManufacture = yearManufacture
        self.bodyValume = bodyValume
        self.engineCondition = engineCondition
        self.windowCondition = windowCondition
        self.filledBodyValume = filledBodyValume
    }
    
    init(model: String){
        self.model = model
    }
    
    init?(model: String, bodyValume: Double){
        guard bodyValume > 0 else { return nil }
        self.model = model
        self.bodyValume = bodyValume
    }
    
    init?(model: String, yearManufacture: Int, bodyValume: Double){
        guard yearManufacture > 0 && bodyValume > 0 else { return nil }
        self.model = model
        self.yearManufacture = yearManufacture
        self.bodyValume = bodyValume
    }
    
}

var sportCar1 = SportCar(model: "нива", trunkValume: 40)!
sportCar1.information()
sportCar1.setEnergineCondition(engineCondition: .start)
sportCar1.setWindowCondition(windowCondition: .open)
sportCar1.setFilledTrunkValume(action: .load, valume: 20)
sportCar1.setFilledTrunkValume(action: .load, valume: 20)

var sportCar2 = SportCar(model: "волга", yearManufacture: 1900, trunkValume: 30)!
sportCar2.information()
sportCar2.setEnergineCondition(engineCondition: .notWork)
sportCar2.setWindowCondition(windowCondition: .open)
sportCar2.setFilledTrunkValume(action: .unload, valume: 20)
sportCar2.setFilledTrunkValume(action: .load, valume: 20)

var sportCar3 = SportCar(model: "калина", yearManufacture: 2000, trunkValume: 20, engineCondition: .start, windowCondition: .open, filledTrunkValume: 10)!
sportCar3.information()
sportCar3.setEnergineCondition(engineCondition: .stop)
sportCar3.setWindowCondition(windowCondition: .close)
sportCar3.setFilledTrunkValume(action: .load, valume: 45)
sportCar3.setFilledTrunkValume(action: .load, valume: 10)

var trunkCar1 = TrunkCar(model: "ГАЗ", bodyValume: 200)!
trunkCar1.information()
trunkCar1.setEnergineCondition(engineCondition: .start)
trunkCar1.setWindowCondition(windowCondition: .open)
trunkCar1.setFilledBodyValume(action: .load, valume: 20)
trunkCar1.setFilledBodyValume(action: .load, valume: 20)

var trunkCar2 = TrunkCar(model: "ПАЗ", yearManufacture: 1900, bodyValume: 100)!
trunkCar2.information()
trunkCar2.setEnergineCondition(engineCondition: .notWork)
trunkCar2.setWindowCondition(windowCondition: .open)
trunkCar2.setFilledBodyValume(action: .unload, valume: 20)
trunkCar2.setFilledBodyValume(action: .load, valume: 20)

var trunkCar3 = TrunkCar(model: "Камаз", yearManufacture: 2000, bodyValume: 200, engineCondition: .start, windowCondition: .open, filledBodyValume: 50)!
trunkCar3.information()
trunkCar3.setEnergineCondition(engineCondition: .stop)
trunkCar3.setWindowCondition(windowCondition: .close)
trunkCar3.setFilledBodyValume(action: .load, valume: 45)
trunkCar3.setFilledBodyValume(action: .load, valume: 10)

var trunkCar4 = TrunkCar(model: "Просто грузовик без кузова")
trunkCar4.information()
trunkCar4.setEnergineCondition(engineCondition: .start)
trunkCar4.setWindowCondition(windowCondition: .open)
trunkCar4.setFilledBodyValume(action: .load, valume: 50)
trunkCar4.setFilledBodyValume(action: .unload, valume: 20)

