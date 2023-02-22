//
//  SearchViewController.swift
//  Search
//
//  Created by Waqas Khan on 21/02/2023.
//
import UIKit

class SearchViewController: BaseViewController, UITextFieldDelegate {

    var viewModel: SearchViewModel!
    
    // MARK: - Outlets
    @IBOutlet private var tableviewSearch: UITableView!
    @IBOutlet private var textfieldSearch: UITextField!
    @IBOutlet private var buttonSearchClear: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.viewModelDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewModelWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.viewModelWillDisappear()
    }
    
    // MARK: - Set / Update Views
    override func setupView() {
        textfieldSearch.delegate = self
        textfieldSearch.becomeFirstResponder()
        textfieldSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        setTableViews()
    }
    
    private func setTableViews() {
        tableviewSearch.delegate = self
        tableviewSearch.dataSource = self
        tableviewSearch.sectionHeaderTopPadding = 0
        tableviewSearch.keyboardDismissMode = .onDrag
        setupTableViewNib()
    }

    private func setupTableViewNib() {
        tableviewSearch.register(cellType: SearchCell.self)
    }
    
    public func reloadTableView() {
        tableviewSearch.reloadData()
        tableviewSearch.layoutIfNeeded()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        switch viewModel.isSearchTextEmpty(text: textField.text) {
        case true:
            textfieldSearch.text = ""
            buttonSearchClear.isHidden = true
        case false:
            buttonSearchClear.isHidden = false
        }
        viewModel.didChangeTextForSearch(text: textField.text.orNil)
    }
    
    func handleClearState() {
        buttonSearchClear.isHidden = true
        textfieldSearch.text = ""
        viewModel.clearSearchResults()
    }
    
    override func showLoader() {
        activityIndicator.startAnimating()
    }
    
    override func hideLoader() {
        DispatchQueue.main.async { [self] in
            activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - Actions
    @IBAction func actionCross(_ sender: UIButton) {
        handleClearState()
        hideLoader()
        view.endEditing(true)
    }
}

// MARK: - Bind Views
extension SearchViewController {
    
    fileprivate func bindViewModel() {
        viewModel.viewSetup = { [weak self] output in
            guard let self = self else { return }
            //handle all your bindings here
            switch output {
            case .setupNavigation:
                self.setupNavigation()
            case .setupView:
                self.setupView()
            case .showLoader:
                self.showLoader()
            case .hideLoader:
                self.hideLoader()
            case .showSuccessMessage(let withMessage):
                self.showSuccessMessage(withMessage)
            case .showErrorMessage(let withMessage):
                self.showErrorMessage(withMessage)
            case .reloadView:
                self.reloadTableView()
            }
        }
    }
}
