//
//  DetailContactViewController.swift
//  RgaContactsApp
//
//  Created by Rafael Nicoleti on 29/01/17.
//  Copyright © 2017 Rafael Nicoleti. All rights reserved.
//

import UIKit
import Siesta.SiestaUI

class DetailContactViewController: UIViewController {

    @IBOutlet weak var viewPhotoContact: UIView!
    @IBOutlet weak var lblBornContact: UILabel!
    @IBOutlet weak var txtNameContact: UITextField!
    @IBOutlet weak var txtEmailContact: UITextField!
    @IBOutlet weak var txtvBioContact: UITextView!
    
    private weak var provider: DataProvider!
    
    var contact: Contact {
        didSet {
            guard contact != oldValue else { return }
            
            update(with: contact)
        }
    }
    
    
    init(provider: DataProvider, contact: Contact) {
        self.provider = provider
        self.contact = contact
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        update(with: contact)
    }
    
    private lazy var imagePhotoContactView: RemoteImageView = {
        let v = RemoteImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        v.contentMode = .scaleToFill
        
        v.layer.mask = self.getMaskLayer(view: v)
        
        return v
    }()
    
    private func update(with contact: Contact) {
        let viewModel = ContactViewModel(contact: contact)
        
        viewPhotoContact.layer.mask = getMaskLayer(view: viewPhotoContact)
        
        viewPhotoContact.addSubview(imagePhotoContactView)
        
        imagePhotoContactView.imageURL = viewModel.contact.photo
        
        txtNameContact.text = viewModel.contact.name
        txtEmailContact.text = viewModel.contact.email
        lblBornContact.text = viewModel.contact.born
        txtvBioContact.text = viewModel.contact.bio
    }
    
    private func getMaskLayer(view: UIView) -> CAShapeLayer {
        let path = UIBezierPath(roundedRect:view.bounds,
                                byRoundingCorners:[.topLeft, .bottomLeft, .topRight, .bottomRight],
                                cornerRadii: CGSize(width: 3.0, height:  3.0))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        
        return maskLayer
    }
}
