//
//  ContactTableViewCell.swift
//  RgaContactsApp
//
//  Created by Rafael Nicoleti on 29/01/17.
//  Copyright © 2017 Rafael Nicoleti. All rights reserved.
//

import UIKit
import Siesta.SiestaUI

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewPhotoContact: UIView!
    @IBOutlet weak var lblNameContact: UILabel!
    @IBOutlet weak var lblEmailContact: UILabel!
    
    var viewModel: ContactViewModel? = nil {
        didSet {
            guard oldValue?.contact != viewModel?.contact else { return }
            
            updateUI()
        }
    }
    
    private lazy var imagePhotoContactView: RemoteImageView = {
        let v = RemoteImageView(frame: self.viewPhotoContact.frame)
        
        v.contentMode = .scaleToFill
        
        let path = UIBezierPath(roundedRect:v.bounds,
                                byRoundingCorners:[.topLeft, .bottomLeft],
                                cornerRadii: CGSize(width: 3.0, height:  3.0))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        v.layer.mask = maskLayer
        
        return v
    }()
    
    
    private func updateUI() {
        viewPhotoContact.addSubview(imagePhotoContactView)
        
        guard let viewModel = viewModel else { return }
        
        imagePhotoContactView.imageURL = viewModel.contact.photo
        
        lblNameContact.text = viewModel.contact.name
        lblEmailContact.text = viewModel.contact.email
    }
}
