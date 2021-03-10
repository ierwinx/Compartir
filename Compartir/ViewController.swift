import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var texto: UILabel!
    @IBOutlet weak var imagen: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func creaAlerta(titulo: String, mensaje: String) {
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alerta, animated: true, completion: nil)
    }

    @IBAction func shareString(_ sender: Any) {
        let activitiController = UIActivityViewController(activityItems: [texto.text ?? ""], applicationActivities: nil)
        activitiController.completionWithItemsHandler =  { (nil, completed, _, error) in
            if completed {
                self.creaAlerta(titulo: "Compartir exitoso", mensaje: "Se compartio correctamente")
            } else {
                self.creaAlerta(titulo: "Error al compartir", mensaje: "se produjo un error al compartir")
            }
        }
        present(activitiController, animated: true, completion: nil)
    }
    
    @IBAction func shareImage(_ sender: Any) {
        guard let imagenguard = imagen.image else { return }
        let activitiController = UIActivityViewController(activityItems: [imagenguard], applicationActivities: nil)
        activitiController.completionWithItemsHandler =  { (nil, completed, _, error) in
            if completed {
                self.creaAlerta(titulo: "Compartir exitoso", mensaje: "Se compartio correctamente")
            } else {
                self.creaAlerta(titulo: "Error al compartir", mensaje: "se produjo un error al compartir")
            }
        }
        present(activitiController, animated: true, completion: nil)
    }
    
    @IBAction func sharePDF(_ sender: Any) {
        guard let pdf = Bundle.main.url(forResource: "buroCredito", withExtension: "pdf") else { return }
        let controlador = UIDocumentInteractionController(url: pdf)
        controlador.delegate = self
        controlador.presentPreview(animated: true)
    }
    
}

extension UIViewController: UIDocumentInteractionControllerDelegate {
    
    public func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
}
