//
//  ProductViewController.swift
//  GetMyCloths
//
//  Created by Ravi Dwivedi on 09/04/23.
//

import UIKit

class ProductViewController: UIViewController {
    
    @IBOutlet weak var tableView:UITableView!
    
    private var productViewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        setUI()
    }
    
    func setUI(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
    }
    
    @IBAction func addBarButtonTapped(_ sender: Any) {
        let parameters = AddProduct(title:"BMW")
        productViewModel.addProduct(parameters: parameters)
    }
    
    deinit {
        print("Deinit of Product called")
    }
}

extension ProductViewController{
    
    private func configureData(){
        initViewModel()
        observeEvent()
    }
    
    private func initViewModel(){
        productViewModel.getAllProducts()
    }
    
    //MARK:- Once product Fetched Data Binding
    private func observeEvent(){
        productViewModel.eventHandler = { [weak self] event in
            guard let self = self else {
                return
            }
            switch event{
            case .startLoading:
                print("Started Loading...")
                break
            case .stopLoading:
                print("Stop Loading...")
                break
            case .dataLoaded:
                // print(self.productViewModel.products)
                print("Data Loaded..")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .newProductAdded(product: let product):
                print("Product Added...")
                print(product)
                
            case .error( let error):
                guard let error = error else {
                    return
                }
                print(error)
            }
        }
    }
    
}

//MARK:- TableView Data Source Method
extension ProductViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productViewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.indentifier, for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        
        let products = self.productViewModel.products[indexPath.row]
        cell.product = products
        return cell
    }
}

//MARK:- TableViewDelegate
extension ProductViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
