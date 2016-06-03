//
//  ViewController.swift
//  RecursosAvancados
//
//  Created by iOS on 03/06/16.
//  Copyright © 2016 Rodrigo. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var newMedia: Bool = false
    
    @IBOutlet weak var imgFoto: UIImageView!

    @IBAction func capturarImagem(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = .Camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
            newMedia = true
        }
        else if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary){
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = .PhotoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        else{
            print("Erro geral")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Métodos de UIImagePickerControllerDelegate
    
    // Quando a imagem é capturada
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        imgFoto.image = image
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if newMedia {
            UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
        }
    }
    
    // Quando ocorre um erro na captura da imagem
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo: UnsafePointer<Void>){
        if error != nil{
            let alerta:UIAlertController = UIAlertController(title: "Mensagem", message: "Não foi possivel salvar a foto", preferredStyle: UIAlertControllerStyle.Alert)
            
            alerta.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil ))
            
            self.presentViewController(alerta, animated: true, completion: nil)
        }
    }
    
    
    // Quando o usuário cancela a captura (botão Cancelar)
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}

