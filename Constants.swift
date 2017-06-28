import Foundation

// Utiliza a API: openweathermap.org
let BASE_URL = "http://api.openweathermap.org/data/2.5"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let DAYS = "&cnt="
let APP_ID = "&appid="
let API_KEY = "e2cb3f7e4d4bb27d57e4bede0cb899e4"

// URL para obter detalhes da temperatura atual
let URL_TEMPERATURA_ATUAL = "\(BASE_URL)/weather?\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)\(API_KEY)"

// URL para obter detalhes da previsão do tempo
let URL_PREVISAO_TEMPO = "\(BASE_URL)/forecast/daily?\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(DAYS)7\(APP_ID)\(API_KEY)"

// Customizações do código
typealias DownloadComplete = () -> ()
