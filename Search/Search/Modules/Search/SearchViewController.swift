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
    @IBOutlet weak var tableviewSearch: UITableView!
    @IBOutlet weak var textfieldSearch: UITextField!
    @IBOutlet weak var buttonSearchClear: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    private lazy var bottomSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.frame = CGRect(x: 0.0, y: 0.0, width: textfieldSearch.bounds.width, height: 70)
        spinner.tintColor = AppColors.black
        spinner.startAnimating()
        return spinner
    }()
    
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
        tableviewSearch.register(cellType: UserCell.self)
    }
    
    public func reloadTableView() {
        tableviewSearch.reloadData()
        tableviewSearch.layoutIfNeeded()
    }
    
    func removeBottomSpinner() {
        tableviewSearch.tableFooterView = nil
        tableviewSearch.tableFooterView?.isHidden = true
    }

    func addBottomSpinner() {
        tableviewSearch.tableFooterView = bottomSpinner
        tableviewSearch.tableFooterView?.isHidden = false
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
            case .removeBottomSpinner:
                self.removeBottomSpinner()
            case .reloadView:
                self.reloadTableView()
            }
        }
    }
}
