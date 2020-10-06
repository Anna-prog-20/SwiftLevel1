import Cocoa

enum EngineCondition: String {
    case start = "запущен"
    case stop = "остановлен"
    case notWork = "сломан"
}

enum WindowCondition: String {
    case open = "открыты"
    case close = "закрыты"
}

enum Action {
    case load
    case unload
}

enum ActionValume {
    case more
    case less
    case equals
}

protocol CarProtocol {
    var model: String { get set }
    var yearManufacture: Int { get set}
    var cargoValume: Double { get set }
    var engineCondition: EngineCondition { get set }
    var windowCondition: WindowCondition { get set }
    var filledCargoValume: Double { get set }
    
    mutating func setEnergineCondition(engineCondition: EngineCondition)
    mutating func setWindowCondition(windowCondition: WindowCondition)
    func check(valume: Double, cargoValume: Double) ->ActionValume
    mutating func setFilledCargoValume(action: Action, valume: Double)
}

extension CarProtocol {
    mutating func setEnergineCondition(engineCondition: EngineCondition) {
            print("Двигатель \(engineCondition.rawValue)...")
            self.engineCondition = engineCondition
        }
    mutating func setWindowCondition(windowCondition:WindowCondition) {
            print("Окна \(windowCondition.rawValue)...")
            self.windowCondition = windowCondition
        }
}

extension CarProtocol {
    func check(valume:Double, cargoValume:Double=0)->ActionValume {
            let a = filledCargoValume + valume
            var action:ActionValume
            if a > cargoValume {
                action = .more
            }
            else if a==0 {
                action = .equals
            }
            else {
                action = .less
            }
            if filledCargoValume == 0.0 && a<0 {
                action = .equals
            }
            return action
        }
}

extension CarProtocol {
    mutating func setFilledCargoValume(action:Action, valume:Double) {
            if valume >= 0 && cargoValume != 0 {
                switch action {
                case .load:
                    print("Пытаемся загрузить \(valume)...")
                    if check(valume: valume,cargoValume: cargoValume) == ActionValume.more{
                        print("Извините, но загрузить возможно всего \(cargoValume-filledCargoValume) единиц")
                    }
                    else if check(valume: valume,cargoValume: cargoValume) == ActionValume.equals {
                        print("Извините, но мета для груза уже нет!")
                    }
                    else {
                        self.filledCargoValume += valume
                        print("Загружаем... Теперь груз составляет \(filledCargoValume) единиц")
                    }
                case .unload:
                    print("Пытаемся выгрузить \(valume)...")
                    if check(valume: -valume) == ActionValume.less{
                        print("Извините, но выгрузить возможно всего \(filledCargoValume) единиц")
                    }
                    else if check(valume: -valume) == ActionValume.equals {
                        print("Извините, но выгружать нечего!")
                    }
                    else {
                        self.filledCargoValume -= valume
                        print("Выгружаем... Теперь груз составляет \(filledCargoValume) единиц")
                    }
                }
            }
            else {
                if valume < 0 {
                    print("Не корректно введено значение!")
                }
                else {
                    print("Данный автомобиль не предназначен для перевозки груза!")
                }
            }
        }
}

enum ExistSpoiler {
    case yes
    case not
}

enum Color: String {
    case white = "белый"
    case black = "черный"
    case red = "красный"
    case yellow = "желтый"
    case notColor
}

struct Spoiler {
    var existSpoiler: ExistSpoiler = .not
    var color: Color
    
    init(exist: ExistSpoiler = .yes, color: Color = .white) {
        self.existSpoiler=exist
        self.color=color
    }
    
    init(exist: ExistSpoiler = .not) {
        self.existSpoiler = exist
        self.color = .notColor
    }
}

class SportCar: CarProtocol {
    var model: String
    var yearManufacture: Int = 1900
    var cargoValume: Double = 0
    var engineCondition: EngineCondition = .stop
    var windowCondition: WindowCondition = .close
    var filledCargoValume: Double = 0
    
    var spoiler: Spoiler = Spoiler(exist: .not)
    static var countSportCar = 0
    
    init(model: String){
        self.model = model
        SportCar.countSportCar += 1
    }
    
    init?(model: String, yearManufacture: Int, cargoValume: Double, engineCondition: EngineCondition, windowCondition: WindowCondition, filledCargoValume: Double, spoiler: Spoiler) {
        guard yearManufacture > 0 && cargoValume > 0 else { return nil }
        self.model = model
        self.yearManufacture = yearManufacture
        self.cargoValume = cargoValume
        self.engineCondition = engineCondition
        self.windowCondition = windowCondition
        self.filledCargoValume = filledCargoValume
        self.spoiler = spoiler
        SportCar.countSportCar += 1
    }
    
    init?(model: String, cargoValume: Double) {
        guard cargoValume > 0 else { return nil }
        self.model = model
        self.cargoValume = cargoValume
        SportCar.countSportCar += 1
    }
    
    init?(model: String, yearManufacture: Int, cargoValume: Double) {
        guard yearManufacture > 0 && cargoValume > 0 else { return nil }
        self.model = model
        self.yearManufacture = yearManufacture
        self.cargoValume = cargoValume
        SportCar.countSportCar += 1
    }
    
    func changeColorSpoiler(color: Color) {
        if spoiler.color != color {
            self.spoiler.color = color
            print("Спойлер перекрашен в \(color.rawValue) цвет")
        }
        else {
            print("Спойлеру обновили \(color.rawValue) цвет")
        }
    }
    
    func installSpoiler() {
        if spoiler.existSpoiler == .yes {
            print("Спойлер уже установлен!")
        }
        else {
            self.spoiler.existSpoiler = .yes
            print("Установка спойлера прошла успешно!")
        }
    }
    
    func installSpoiler(color: Color) {
        if spoiler.existSpoiler == .yes {
            print("Спойлер уже установлен!")
        }
        else {
            self.spoiler.existSpoiler = .yes
            self.spoiler.color = color
            print("Установка спойлера (\(color.rawValue)) прошла успешно!")
        }
    }
    
    func uninstallSpoiler() {
        if spoiler.existSpoiler == .yes {
            self.spoiler.existSpoiler = .not
            print("Спойлер снят!")
        }
        else {
            print("К сожалению, спойлер уже снят!")
        }
        
    }
    
    static func countSportCarInfo() {
        if countSportCar != 0 {
            print("Общее количество легковых автомобилей равно \(countSportCar)")
        }
        else {
            print("Легковые автомобили отсутствуют!")
        }
    }
    
    deinit {
        SportCar.countSportCar -= 1
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        return """
                ********Легковой автомобиль*********
                Модель: \(model)
                Год выпуска: \(yearManufacture == 0 ? "не известен" : "\(self.yearManufacture)")
                Двигатель: \(engineCondition.rawValue)
                Окна: \(windowCondition.rawValue)
                Объем груза, вмещающий в себя автомобиль: \(cargoValume)
                Заполненный объем: \(filledCargoValume)
                \(spoiler.existSpoiler == ExistSpoiler.yes ? "У автомобиля есть спойлер, цвет \(spoiler.color.rawValue)" : "Спойлер отсутствует")
            """
    }
}

class TrunkCar: CarProtocol {
    var model: String = ""
    var yearManufacture: Int = 1900
    var cargoValume: Double = 0
    var engineCondition: EngineCondition = .stop
    var windowCondition: WindowCondition = .close
    var filledCargoValume: Double = 0
    
    var trailerValume: Double = 0
    static var countTrunkCar = 0
    
    func addTrailer(trailerValume: Double) {
        self.trailerValume = trailerValume
        self.cargoValume += trailerValume
        print("Установили дополнительный кузов с объемом \(trailerValume) единиц")
        print("Теперь грузовик может загрузить \(cargoValume) единиц")
    }
    
    init(model: String){
        self.model = model
        TrunkCar.countTrunkCar += 1
    }
    
    init?(model: String, yearManufacture: Int, cargoValume: Double, engineCondition: EngineCondition, windowCondition: WindowCondition, filledCargoValume: Double) {
        guard yearManufacture > 0 && cargoValume > 0 else { return nil }
        self.model = model
        self.yearManufacture = yearManufacture
        self.cargoValume = cargoValume
        self.engineCondition = engineCondition
        self.windowCondition = windowCondition
        self.filledCargoValume = filledCargoValume
        TrunkCar.countTrunkCar += 1
    }
    
    init?(model: String, cargoValume: Double) {
        guard cargoValume > 0 else { return nil }
        self.model = model
        self.cargoValume = cargoValume
        TrunkCar.countTrunkCar += 1
    }
    
    init?(model: String, yearManufacture: Int, cargoValume: Double) {
        guard yearManufacture > 0 && cargoValume > 0 else { return nil }
        self.model = model
        self.yearManufacture = yearManufacture
        self.cargoValume = cargoValume
        TrunkCar.countTrunkCar += 1
    }
    
    static func countTrunkCarInfo() {
        if countTrunkCar != 0 {
            print("Общее количество грузовых автомобилей равно \(countTrunkCar)")
        }
        else {
            print("Грузовые автомобили отсутствуют!")
        }
    }
    
    deinit {
        TrunkCar.countTrunkCar -= 1
    }
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return """
                ********Грузовой автомобиль*********
                Модель: \(model)
                Год выпуска: \(yearManufacture == 0 ? "не известен" : "\(self.yearManufacture)")
                Двигатель: \(engineCondition.rawValue)
                Окна: \(windowCondition.rawValue)
                Объем груза, вмещающий в себя автомобиль: \(cargoValume)
                Заполненный объем: \(filledCargoValume)
            """
    }
}

var sportCar1, sportCar2, sportCar3 :SportCar
if let a = SportCar(model: "нива", cargoValume: -40) {
    sportCar1 = a
    print(sportCar1)
    sportCar1.setEnergineCondition(engineCondition: .start)
    sportCar1.setWindowCondition(windowCondition: .open)
    sportCar1.setFilledCargoValume(action: .load, valume: 20)
    sportCar1.setFilledCargoValume(action: .load, valume: 20)
    sportCar1.installSpoiler(color: .yellow)
    print(sportCar1)
}

if let a = SportCar(model: "волга", yearManufacture: 1900, cargoValume: 30) {
    sportCar2 = a
    print(sportCar2)
    sportCar2.setEnergineCondition(engineCondition: .notWork)
    sportCar2.setWindowCondition(windowCondition: .open)
    sportCar2.setFilledCargoValume(action: .unload, valume: 20)
    sportCar2.setFilledCargoValume(action: .load, valume: 20)
    sportCar2.installSpoiler()
    sportCar2.changeColorSpoiler(color: .red)
    sportCar2.uninstallSpoiler()
    print(sportCar2)
}

if let a = SportCar(model: "калина", yearManufacture: 2000, cargoValume: 20, engineCondition: .start, windowCondition: .open, filledCargoValume: 10, spoiler: Spoiler(exist: .yes, color: .red)) {
    sportCar3 = a
    print(sportCar3)
    sportCar3.setEnergineCondition(engineCondition: .stop)
    sportCar3.setWindowCondition(windowCondition: .close)
    sportCar3.setFilledCargoValume(action: .load, valume: 45)
    sportCar3.setFilledCargoValume(action: .load, valume: 10)
    sportCar3.installSpoiler()
    sportCar3.changeColorSpoiler(color: .black)
    print(sportCar3)
}

var trunkCar1, trunkCar2, trunkCar3, trunkCar4: TrunkCar
if let a = TrunkCar(model: "ГАЗ", cargoValume: 200) {
    trunkCar1 = a
    print(trunkCar1)
    trunkCar1.setEnergineCondition(engineCondition: .start)
    trunkCar1.setWindowCondition(windowCondition: .open)
    trunkCar1.setFilledCargoValume(action: .load, valume: 20)
    trunkCar1.setFilledCargoValume(action: .load, valume: 20)
    trunkCar1.addTrailer(trailerValume: 70)
    trunkCar1.setFilledCargoValume(action: .load, valume: 70)
}

if let a = TrunkCar(model: "ПАЗ", yearManufacture: 1900, cargoValume: 100) {
    trunkCar2 = a
    print(trunkCar2)
    trunkCar2.setEnergineCondition(engineCondition: .notWork)
    trunkCar2.setWindowCondition(windowCondition: .open)
    trunkCar2.setFilledCargoValume(action: .unload, valume: 20)
    trunkCar2.setFilledCargoValume(action: .load, valume: 20)
}

if let a = TrunkCar(model: "Камаз", yearManufacture: 2000, cargoValume: 200, engineCondition: .start, windowCondition: .open, filledCargoValume: 50) {
    trunkCar3 = a
    print(trunkCar3)
    trunkCar3.setEnergineCondition(engineCondition: .stop)
    trunkCar3.setWindowCondition(windowCondition: .close)
    trunkCar3.setFilledCargoValume(action: .load, valume: 45)
    trunkCar3.setFilledCargoValume(action: .load, valume: 10)
}

trunkCar4 = TrunkCar(model: "Просто грузовик без кузова")
print(trunkCar4)
trunkCar4.setEnergineCondition(engineCondition: .start)
trunkCar4.setWindowCondition(windowCondition: .open)
trunkCar4.setFilledCargoValume(action: .load, valume: 50)
trunkCar4.addTrailer(trailerValume: 50)
trunkCar4.setFilledCargoValume(action: .unload, valume: 20)

SportCar.countSportCarInfo()
TrunkCar.countTrunkCarInfo()

//Это просто эксперемент для себя :)))
let car = [SportCar(model: "sdfsf"), TrunkCar(model: "sdbdbakksb")] as [CarProtocol]
print(car[0])
print(car[1])
