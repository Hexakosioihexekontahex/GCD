//
//  SecondVC.swift
//  GCD
//
//  Created by Roman Melnik on 27.02.2020.
//  Copyright © 2020 Roman Melnik. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImage()
        
        delay(3) {
            self.loginAlert()
        }
    }
    
    fileprivate func delay(_ delay: Int, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
    
    fileprivate func loginAlert() {
        
        let ac = UIAlertController(title: "Зарегистрированы?", message: "Введите Ваш логин и пароль", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        ac.addAction(ok)
        ac.addAction(cancel)
        
        ac.addTextField { (usernameTF) in
            usernameTF.placeholder = "Введите логин"
        }
        
        ac.addTextField { (userpasswordTF) in
            userpasswordTF.placeholder = "Введите пароль"
            userpasswordTF.isSecureTextEntry = true
        }
        
        self.present(ac, animated: true, completion: nil)
    }
    
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://global-uploads.webflow.com/5c741219fd0819aad790e78b/5cc21a272ddf6fa4e2a8b125_kotlin-multiplatform.png")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        DispatchQueue.global(qos: .utility)
            .async {
                guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
            
                DispatchQueue.main.async {
                    
                    self.image = UIImage(data: imageData)
                }
        }
        
    }
}
