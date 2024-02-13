import Foundation

class MathService {
    func generateExample() -> String {
        let number1 = Int.random(in: 1...10)
        let number2 = Int.random(in: 1...10)
        let operatorIndex = Int.random(in: 0...2)
        let operatorChar: Character
        
        switch operatorIndex {
        case 0:
            operatorChar = "+"
        case 1:
            operatorChar = "-"
        default:
            operatorChar = "*"
        }
        
        return "\(number1) \(operatorChar) \(number2)"
    }
    
    func resolveExample(_ example: String) -> Double? {
        let expression = NSExpression(format: example)
        return expression.expressionValue(with: nil, context: nil) as? Double
    }
    
    func generateAnswers(_ result: Double) -> [String] {
        let correctAnswer = String(format: "%.2f", result)
        var answers = [correctAnswer]
        
        while answers.count < 4 {
            let randomAnswer = String(format: "%.2f", Double.random(in: result - 10...result + 10))
            if !answers.contains(randomAnswer) {
                answers.append(randomAnswer)
            }
        }
        
        answers.shuffle()
        return answers
    }
}

// Использование сервиса математики
//let service = MathService()
//
//let example = service.generateExample()
//print("Пример:", example)
//
//if let result = service.resolveExample(example) {
//    print("Результат:", result)
//    
//    let answers = service.generateAnswers(result)
//    print("Варианты ответов:", answers)
//}
