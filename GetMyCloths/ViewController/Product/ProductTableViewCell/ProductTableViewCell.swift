//
//  ProductTableViewCell.swift
//  GetMyCloths
//
//  Created by Ravi Dwivedi on 09/04/23.
//

import UIKit
import Kingfisher

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var descriptionLabel:UILabel!
    @IBOutlet weak var categoryLabel:UILabel!
    @IBOutlet weak var priceLabel:UILabel!
    
    
    @IBOutlet weak var imageVw:UIImageView!
    @IBOutlet weak var productBackGroundView:UIView!
    @IBOutlet weak var rateButton:UIButton!
    @IBOutlet weak var buyButton:UIButton!
    
    static let indentifier = "ProductTableViewCell"
    
    var product:Products? {
        didSet{
            productDetailConfigurations()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        productBackGroundView.clipsToBounds = false
        productBackGroundView.layer.cornerRadius = 15
        productBackGroundView.backgroundColor = .systemGray6
        imageVw.layer.cornerRadius = 10
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func productDetailConfigurations(){
        
        guard let product = self.product else {
            return
        }
        
        titleLabel.text = product.title
        descriptionLabel.text = product.description
        categoryLabel.text = product.category
        priceLabel.text =  "$\(product.price)"
        rateButton.setTitle("\(product.rating.rate)", for: .normal)
        guard let urlString = product.image else {
            return
        }
        imageVw.setImage(with: urlString)
    }
    
}
