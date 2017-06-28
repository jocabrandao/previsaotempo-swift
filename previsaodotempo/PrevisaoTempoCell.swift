import UIKit

class PrevisaoTempoCell: UITableViewCell {
 
    @IBOutlet weak var imgPrevisaoDia: UIImageView!
    @IBOutlet weak var diaSemana: UILabel!
    @IBOutlet weak var tipoPrevisaoDia: UILabel!
    @IBOutlet weak var maiorTemperaturaDia: UILabel!
    @IBOutlet weak var menorTemperaturaDia: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populateCell(previsaoTempo: PrevisaoTempo){
        self.imgPrevisaoDia.image = UIImage(named: previsaoTempo.tipoTempo)
        self.diaSemana.text = previsaoTempo.data
        self.tipoPrevisaoDia.text = previsaoTempo.tipoTempo
        self.maiorTemperaturaDia.text = "\(previsaoTempo.maiorTemperatura)°"
        self.menorTemperaturaDia.text = "\(previsaoTempo.menorTemperatura)°"
    }
}
