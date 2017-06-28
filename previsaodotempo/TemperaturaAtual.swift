import UIKit
import Alamofire

class TemperaturaAtual{

    var _dataAtual: String!
    var _temperaturaAtual: Double!
    var _localidadeAtual: String!
    var _tipoTempoAtual: String!
    
    var dataAtual: String {
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale.current
        
        let dateComponents = calendar.dateComponents([.day, .month, .year], from: Date())
        let monthName = calendar.monthSymbols[dateComponents.month! - 1]
        
        self._dataAtual = "Hoje, \(dateComponents.day!) \(monthName) de \(dateComponents.year!)"
        
        return _dataAtual
    }
    
    var temperaturaAtual: Double {
        if _temperaturaAtual == nil {
            _temperaturaAtual = 0.0
        }
        return _temperaturaAtual
    }
    
    var localidadeAtual: String{
        if _localidadeAtual == nil {
            _localidadeAtual = ""
        }
        return _localidadeAtual
    }
    
    var tipoTempoAtual: String {
        if _tipoTempoAtual == nil {
            _tipoTempoAtual = ""
        }
        return _tipoTempoAtual
    }
    
    func donwloadDetalhesTemperaturaAtual(completed: @escaping DownloadComplete){
        
        let urlAPI = URL(string: URL_TEMPERATURA_ATUAL)
        Alamofire.request(urlAPI!).responseJSON { response in

            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                if let name = dict["name"] as? String {
                    self._localidadeAtual = name.capitalized
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]{
                    
                    if let main = weather[0]["main"] as? String{
                        self._tipoTempoAtual = main.capitalized
                    }
                    
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject>{
                    
                    if let temp = main["temp"] as? Double{
                        let kelvinToCelsius = (temp - 273.15)
                        let kelvinToCelsiusRouded = Double(round(10 * kelvinToCelsius/10))
                        self._temperaturaAtual = kelvinToCelsiusRouded
                    }
                    
                }
                
            }
            completed()
        }
    }
}


