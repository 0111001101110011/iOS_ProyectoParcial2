//
//  AñadirCargaGasolina.swift
//  iOSProyectoParcial2
//
//  Created by Alumno on 10/9/19.
//  Copyright © 2019 Alumno. All rights reserved.
//

import Foundation
import UIKit

class AñadirCargaGasolinaController : UIViewController {
    
    var gasolina : Gasolina?
    
    var callbackActualizarTabla: (() -> Void)?
    
    @IBOutlet weak var txtLitros: UITextField!
    @IBOutlet weak var txtCosto: UITextField!
    
    override func viewDidLoad() {
        self.title = "Nueva Carga de Gasolina"
    }
    
    @IBAction func doTapGuardar(_ sender: Any) {

        gasolina?.Litros = (txtLitros.text! as NSString).integerValue
        gasolina?.Costo = (txtCosto.text! as NSString).integerValue
        
        callbackActualizarTabla!()
        
        self.navigationController?.popViewController(animated: true)
    }
}
