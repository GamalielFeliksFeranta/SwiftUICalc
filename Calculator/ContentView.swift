//
//  ContentView.swift
//  Calculator
//
//  Created by MacBook Pro on 30/09/23.
//

import SwiftUI

enum SemuaButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "X"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negativePositive = "-/+"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return Color.pink // You can change this to your preferred color
        case .clear, .negativePositive, .percent:
            return Color.pink // You can change this to your preferred color
        default:
            return Color.pink
        }
    }
}
struct ContentView: View {
    
    enum Operation {
        case add, subtract, multiply, divide, none
    }
    
    @State var value = "0"
    @State var angka = 0
    @State var currentOperation: Operation = .none
    
    let buttons: [[SemuaButton]] = [
        [.clear, .negativePositive, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(value)
                        .font(.system(size: 70))
                        .foregroundColor(.white)
                        .bold()
                }
                .padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.pencet(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 30))
                                    .frame(width: self.buttonWidth(item: item), height: self.buttonHeight())
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item) / 2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    func pencet(button: SemuaButton) {
        switch button {
        case .add, .subtract, .multiply, .divide:
            if button == .add {
                self.currentOperation = .add
                self.angka = Int(Double(self.value) ?? 0.0)
            } else if button == .subtract {
                self.currentOperation = .subtract
                self.angka = Int(Double(self.value) ?? 0.0)
            } else if button == .multiply {
                self.currentOperation = .multiply
                self.angka = Int(Double(self.value) ?? 0.0)
            } else if button == .divide {
                self.currentOperation = .divide
                self.angka = Int(Double(self.value) ?? 0.0)
            }
            if button != .equal {
                self.value = "0"
            }
            
        case .equal:
            let currentValue = Double(self.value) ?? 0.0
            switch self.currentOperation {
            case .add: self.value = "\(angka + Int(currentValue))"
            case .subtract: self.value = "\(angka - Int(currentValue))"
            case .multiply: self.value = "\(angka * Int(currentValue))"
            case .divide: self.value = "\(angka / Int(currentValue))"
            case .none:
                break
            }
            
            self.currentOperation = .none
            self.angka = 0
            
            
            
            
        case .clear:
            self.value = "0"
        case .decimal:
            if !self.value.contains(".") {
                self.value += "."
            }
        case .negativePositive:
            if self.value != "0" {
                if self.value.hasPrefix("-") {
                    self.value.remove(at: self.value.startIndex)
                } else {
                    self.value = "-" + self.value
                }
            }
        case .percent:
            if let number = Double(self.value) {
                self.value = String(number / 100)

            }
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            } else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func buttonWidth(item: SemuaButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
