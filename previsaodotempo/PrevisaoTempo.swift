import UIKit
import Alamofire

class PrevisaoTempo {

    var _data: String!
    var _tipoTempo: String!
    var _maiorTemperatura: String!
    var _menorTemperatura: String!
    
    var data: String {
        if _data == nil {
            _data = ""
        }
        return _data
    }

    var tipoTempo: String {
        if _tipoTempo == nil {
            _tipoTempo = ""
        }
        return _tipoTempo
    }
    
    var maiorTemperatura: String {
        if _maiorTemperatura == nil {
            _maiorTemperatura = ""
        }
        return _maiorTemperatura
    }
    
    var menorTemperatura: String {
        if _menorTemperatura == nil {
            _menorTemperatura = ""
        }
        return _menorTemperatura
    }
    
    init(previsaoTempoDict: Dictionary<String, AnyObject>) {
        
        if let temp = previsaoTempoDict["temp"] as? Dictionary<String, AnyObject> {
            
            if let min = temp["min"] as? Double {
                let kelvinToCelsius = (min - 273.15)
                let kelvinToCelsiusRouded = Double(round(10 * kelvinToCelsius/10))
                self._menorTemperatura = "\(kelvinToCelsiusRouded)"
            }
            
            if let max = temp["max"] as? Double {
                let kelvinToCelsius = (max - 273.15)
                let kelvinToCelsiusRouded = Double(round(10 * kelvinToCelsius/10))
                self._maiorTemperatura = "\(kelvinToCelsiusRouded)"
            }
            
        }
        
        if let weather = previsaoTempoDict["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self._tipoTempo = main
            }
        }
        
        if let date = previsaoTempoDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._data = unixConvertedDate.dayOfTheWeek()
        }
        
    }
    
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
