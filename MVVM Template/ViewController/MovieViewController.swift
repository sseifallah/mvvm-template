//
//  MovieViewController.swift
//  MVVMDemo
//
//  Created by Shantaram K on 20/03/19.
//  Copyright © 2019 Shantaram K. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterButton: UIButton!
    
    //MARK: Variables
    
    let viewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        prepareUI()
        fetchMovieList()
        
        filterButton.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
    }
    
    func setData() {
        self.navigationItem.title = "Movie"
    }
    
    func prepareUI() {
        prepareTableView()
        prepareViewModelObserver()
    }
    
    
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieViewCell", bundle: nil), forCellReuseIdentifier: "MovieViewCell")
        
    }
}


//MARK: Action

extension MovieViewController {
    
    @objc func filterButtonTapped(_ button: UIButton) {
        viewModel.movies = viewModel.movies?.sortByName()
    }
}
//MARK: Private Methods

extension MovieViewController {
    
    func fetchMovieList() {
        viewModel.fetchMovieList()
    }
    
    func prepareViewModelObserver() {
        self.viewModel.movieDidChanges = { (finished, error) in
            if !error {
                self.reloadTableView()
            }
        }
    }
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
}

// MARK: - UITableView Delegate And Datasource Methods

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: MovieViewCell = tableView.dequeueReusableCell(withIdentifier: "MovieViewCell", for: indexPath as IndexPath) as? MovieViewCell else {
            fatalError("AddressCell cell is not found")
        }
        
        let movie = viewModel.movies![indexPath.row]
        cell.movieItem = movie
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 160
        tableView.rowHeight = UITableView.automaticDimension
        return UITableView.automaticDimension
    }
}
