import UIKit
import CoreLocation
import Alamofire

class PrevisaoTempoVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var lblDataAtual: UILabel!
    @IBOutlet weak var lblTemperaturaAtual: UILabel!
    @IBOutlet weak var lblLocalidadeAtual: UILabel!
    @IBOutlet weak var lblIconeTemperatuaAtual: UIImageView!
    @IBOutlet weak var lblTipoTempoAtual: UILabel!
    @IBOutlet weak var tbvTemperaturaProximosDias: UITableView!
    @IBOutlet weak var tbwPrevisaoTempo: UITableView!
    @IBOutlet weak var headerArea: CustomHeaderView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var temperaturaAtual: TemperaturaAtual!
    var previsoesTempo = [PrevisaoTempo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerArea.addDropShadow()
        
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startMonitoringSignificantLocationChanges()
        
        self.temperaturaAtual = TemperaturaAtual()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {

            self.currentLocation = self.locationManager.location
            Location.sharedInstance.latitude = self.currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = self.currentLocation.coordinate.longitude

            self.temperaturaAtual.donwloadDetalhesTemperaturaAtual {
                self.donwloadDetalhesPrevisaoTempo {
                    self.updateMainUI()
                    self.tbwPrevisaoTempo.reloadData()
                }
            }
            
        } else {
            
            self.locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
            
        }
    }
    
    func donwloadDetalhesPrevisaoTempo(completed: @escaping DownloadComplete){
        let urlAPI = URL(string: URL_PREVISAO_TEMPO)
        
        Alamofire.request(urlAPI!).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for obj in list {
                        let prevTemp = PrevisaoTempo(previsaoTempoDict: obj)
                        self.previsoesTempo.append(prevTemp)
                    }
                }
                self.previsoesTempo.remove(at: 0)
            }
            completed()
        }
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.previsoesTempo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cellTemperatura", for: indexPath) as? PrevisaoTempoCell {
        
            let previsaoTempo = previsoesTempo[indexPath.row]
            cell.populateCell(previsaoTempo: previsaoTempo)
            
            return cell
        } else {
            return PrevisaoTempoCell()
        }
        
    }
    
    func updateMainUI(){
        self.lblDataAtual.text = temperaturaAtual.dataAtual
        self.lblTemperaturaAtual.text = "\(temperaturaAtual.temperaturaAtual)°"
        self.lblTipoTempoAtual.text = temperaturaAtual.tipoTempoAtual
        self.lblLocalidadeAtual.text = temperaturaAtual.localidadeAtual
        self.lblIconeTemperatuaAtual.image = UIImage(named: temperaturaAtual.tipoTempoAtual)
    }
    
    
}

