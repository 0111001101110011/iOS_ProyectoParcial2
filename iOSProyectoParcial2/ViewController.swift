//
//  ViewController.swift
//  iOSProyectoParcial2
//
//  Created by Alumno on 10/7/19.
//  Copyright © 2019 Alumno. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tvCarros: UITableView!
    
    var carros : [Carro] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Carros"
        
        carros.append(Carro(modelo: "Grand Cherokee", marca: "Jeep", año: "2018", propietario: "Tank Dempsey", placa: "ACR-935-T7", foto: "JEEP"))
        carros.append(Carro(modelo: "Enzo", marca: "Ferrari", año: "1989", propietario: "Edward Richtofen", placa: "GAP-333-F1", foto: "ENZO"))
   
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celdaCarro") as? CeldaCarroController
        
        celda?.lblPlaca.text = carros[indexPath.row].placa
        celda?.lblModelo.text = carros[indexPath.row].modelo
        celda?.lblMarca.text = carros[indexPath.row].marca
        celda?.lblAño.text = "\(carros[indexPath.row].año!)"
        celda?.lblPropietario.text = carros[indexPath.row].propietario
        celda?.imgCarro.image = UIImage(named: carros[indexPath.row].foto!)
        return celda!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
    
    func recargarTabla() {
        tvCarros.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEditarCarro" {
            let destino = segue.destination as? EditarCarroController
            
            destino?.carro = carros[tvCarros.indexPathForSelectedRow!.row]
            
            destino?.callbackActualizarTabla = recargarTabla
        }
        else
            if segue.identifier == "goToAñadirCarro" {
                let destino = segue.destination as? AñadirCarroController
                
                carros.append(Carro(modelo: "", marca: "", año: "", propietario: "", placa: "", foto: ""))
                
                destino?.carro = carros[carros.count - 1]
                
                destino?.callbackActualizarTabla = recargarTabla
        }
    }
}

