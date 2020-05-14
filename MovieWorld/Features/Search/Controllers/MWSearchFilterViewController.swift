//
//  MWSearchFilterViewController.swift
//  MovieWorld
//
//  Created by Admin on 11/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit

protocol SearchDelegate: class {
    func buttonPressed(_ movies: [MWMovie])
}

class MWSearchFilterViewController: MWViewController {
    
    // MARK: - Variables
    
    weak var delegate: SearchDelegate?
    
    private let pickerDataSource = UIPickerViewDS()
    private let collectionDataSource = GenreCollectionViewDS()
    
    private var buttonSize = CGSize(width: 344, height: 44)
    private var year: String = ""
    private var voteMin: String = ""
    private var voteMax: String = ""
    
    var countries: [String] = []
    var genres: [GenreModel] = []
    
    // MARK: - Gui variables
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 30
        return stack
    }()
    private lazy var datePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self.pickerDataSource
        picker.delegate = self.pickerDataSource
        picker.isHidden = true
        return picker
    }()
  
    private lazy var countryLabel: MWSearchViewWithArrow = {
        let label = MWSearchViewWithArrow()
        label.secondLabel.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openTableView(sender:)))
        gesture.view?.endEditing(true)
        label.secondLabel.addGestureRecognizer(gesture)
        label.firstLabel.text = "Country"
        return label
    }()
    
    private lazy var yearLabel: MWSearchViewWithArrow = {
        let label = MWSearchViewWithArrow()
        label.secondLabel.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(yearChanged))
        gesture.view?.endEditing(true)
        label.secondLabel.addGestureRecognizer(gesture)
        label.firstLabel.text = "Year"
        return label
    }()
    
    private lazy var genreCollection: MWGenreCollectionView = {
        let collection = MWGenreCollectionView()
        collection.collectionView.delegate = self.collectionDataSource
        collection.collectionView.dataSource = self.collectionDataSource
        
        return collection
    }()

    private lazy var rating: MWSearchWithSlider = {
        let slider = MWSearchWithSlider()
        
        return slider
    }()
 
    private lazy var requestButton: MWRedButton = {
        let button = MWRedButton()
        button.addTarget(self, action: #selector(sendRequest), for: .touchUpInside)
        button.setTitle("Show", for: .normal)
        return button
    }()
    
    // MARK: - UI Functions
    
    private func setupUI() {
        self.view.addSubview(requestButton)
        self.view.addSubview(stackView)
        
        self.stackView.addArrangedSubview(yearLabel)
        self.stackView.addArrangedSubview(countryLabel)
        
        self.view.addSubview(rating)
        self.view.addSubview(datePicker)
        self.view.addSubview(genreCollection)
        
        self.pickerDataSource.delegate = self
        self.collectionDataSource.delegate = self
        
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        self.genreCollection.snp.makeConstraints { (make) in
            make.height.equalTo(80)
            make.top.equalToSuperview().offset(140)
            make.left.right.equalToSuperview()
        }
        self.requestButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(buttonSize)
            make.bottom.equalToSuperview().inset(100)
        }
        
        self.stackView.snp.makeConstraints { (make) in
            make.top.equalTo(genreCollection.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        self.rating.snp.makeConstraints { (make) in
            make.top.equalTo(self.stackView.snp.bottom).offset(25)
            make.height.equalTo(60)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        self.datePicker.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
        }
    }
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    // MARK: - Private Functions
    
    private func discoverMovie(year: String? = "", voteMin: String? = "", voteMax: String? = "", counries: [String]) {
        MWNet.sh.request(urlPath: Endpoints.getMovieDiscover.path,
                         parameters: ["year" : year ?? "",
                                      "region" : (countries.joined(separator: "+")),
                            "vote_average.gte" : voteMin ?? "",
                            "vote_average.lte" : voteMax ?? ""],
                         successHandler: { [weak self] (_ response: MWApiResults) in
                            self?.delegate?.buttonPressed(response.results)
                            MWI.sh.popVC()
        }) { [weak self] (error) in
            DispatchQueue.main.async {
                self?.alert(message: error.description)
            }
        }
    }
    
    @objc private func popVC() {
        MWI.sh.popVC()
    }
    
    @objc private func yearChanged(sender: UIDatePicker) {
        self.datePicker.isHidden = false
        self.yearLabel.secondLabel.inputView = datePicker
    }
    
    @objc private func openTableView(sender: UITextField) {
        let vc = MWSearchCountriesViewController()
        vc.tableViewDataSource.delegate = self
        MWI.sh.push(vc: vc)
    }

    // MARK: - Functions
    
    @objc func sendRequest() {
        self.discoverMovie(year: "2019", counries: self.countries)
    }
}

// MARK: - Extensions

extension MWSearchFilterViewController: UIPickerDelegate {
    func didChooseYear(_ year: Int) {
        self.yearLabel.secondLabel.text = String(year)
    }
}

extension MWSearchFilterViewController: UITextFieldDelegate {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.yearLabel.inputView?.endEditing(true)
        self.datePicker.isHidden = true
    }
}

extension MWSearchFilterViewController: GenreCollectionViewDelegate {
    func genreChosen(genre: GenreModel) {
        self.genres.append(genre)
    }
}

extension MWSearchFilterViewController: CountriesTableViewControllerDelegate {
    func countryDeselected(_ country: CountryModel) {
        if countries.contains(country.code!) {
            if let countryToDeleteIndex =  countries.firstIndex(of: country.code!) {
                self.countries.remove(at: countryToDeleteIndex)
            }
        }
    }
    
    func countrySelected(_ country: CountryModel) {
        self.countries.append(country.code!)
    }
}
