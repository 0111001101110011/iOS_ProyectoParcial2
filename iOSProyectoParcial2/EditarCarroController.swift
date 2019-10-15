//
//  EditarCarroController.swift
//  iOSProyectoParcial2
//
//  Created by Alumno on 10/8/19.
//  Copyright © 2019 Alumno. All rights reserved.
//

import Foundation
import UIKit

class EditarCarroController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var btnEditar: UIBarButtonItem!
    var editState = 0
    
    @IBOutlet weak var tvCargasGasolina: UITableView!
    
    var gasolinas : [Gasolina] = []
    
    var carro : Carro?
    
    var callbackActualizarTabla: (() -> Void)?
    
    @IBOutlet weak var txtPlaca: UITextField!
    @IBOutlet weak var txtModelo: UITextField!
    @IBOutlet weak var txtMarca: UITextField!
    @IBOutlet weak var txtAño: UITextField!
    @IBOutlet weak var txtPropietario: UITextField!
    
    override func viewDidLoad() {
        self.title = "Detalles del Carro"
        
        txtPlaca.isUserInteractionEnabled = false
        txtAño.isUserInteractionEnabled = false
        txtMarca.isUserInteractionEnabled = false
        txtModelo.isUserInteractionEnabled = false
        txtPropietario.isUserInteractionEnabled = false
        
        txtPlaca.textColor = UIColor.gray
        txtAño.textColor = UIColor.gray
        txtMarca.textColor = UIColor.gray
        txtModelo.textColor = UIColor.gray
        txtPropietario.textColor = UIColor.gray
        
        txtPlaca.text = carro!.placa
        txtModelo.text = carro!.modelo
        txtMarca.text = carro!.marca
        txtAño.text = carro!.año
        txtPropietario.text = carro!.propietario
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gasolinas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celdaGasolina") as? CeldaGasolinaController
        
        celda?.lblLitros.text = "\(gasolinas[indexPath.row].Litros!)" + " L"
        celda?.lblCosto.text = "$" + "\(gasolinas[indexPath.row].Costo!)" + ".00"
        
        return celda!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func recargarTabla() {
        tvCargasGasolina.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAñadirCargaGasolina" {
            let destino = segue.destination as? AñadirCargaGasolinaController
            
            gasolinas.append(Gasolina(Litros: 0, Costo: 0))
            
            destino?.gasolina = gasolinas[gasolinas.count - 1]
            
            destino?.callbackActualizarTabla = recargarTabla
            
            carro?.carga = destino?.gasolina?.Litros
            carro?.costo = destino?.gasolina?.Costo
        }
    }
    
    @IBAction func doTapEdit(_ sender: Any) {
        if(editState == 0){
            btnEditar.title = "Save"
            
            txtPlaca.isUserInteractionEnabled = true
            txtAño.isUserInteractionEnabled = true
            txtMarca.isUserInteractionEnabled = true
            txtModelo.isUserInteractionEnabled = true
            txtPropietario.isUserInteractionEnabled = true
            
            txtPlaca.textColor = UIColor.black
            txtAño.textColor = UIColor.black
            txtMarca.textColor = UIColor.black
            txtModelo.textColor = UIColor.black
            txtPropietario.textColor = UIColor.black
            
            editState += 1
        }
        else{
            carro?.placa = txtPlaca.text
            carro?.modelo = txtModelo.text
            carro?.marca = txtMarca.text
            carro?.año = txtAño.text
            carro?.propietario = txtPropietario.text
            
            callbackActualizarTabla!()
            
            btnEditar.title = "Edit"
            
            txtPlaca.isUserInteractionEnabled = true
            txtAño.isUserInteractionEnabled = true
            txtMarca.isUserInteractionEnabled = true
            txtModelo.isUserInteractionEnabled = true
            txtPropietario.isUserInteractionEnabled = true
            
            txtPlaca.textColor = UIColor.gray
            txtAño.textColor = UIColor.gray
            txtMarca.textColor = UIColor.gray
            txtModelo.textColor = UIColor.gray
            txtPropietario.textColor = UIColor.gray
            
            editState -= 1
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            gasolinas.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
