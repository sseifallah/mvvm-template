//
//  MVVM_TemplateTests.swift
//  MVVM TemplateTests
//
//  Created by MacBook Pro on 6/18/20.
//  Copyright © 2020 Seifallah Selmi. All rights reserved.
//

import XCTest
@testable import MVVM_Template_Dev

class MVVM_TemplateTests: XCTestCase {
    
    var tableView: UITableView!
    private var dataSource: TableViewDataSource!
    private var delegate: TableViewDelegate!

    override func setUp() {
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 200, height: 400), style: .plain)
        let itemXib = UINib.init(nibName: "MovieViewCell",
                                        bundle: nil)
        tableView.register(itemXib,
                           forCellReuseIdentifier: "MovieViewCell")
        
        dataSource = TableViewDataSource()
        delegate = TableViewDelegate()
        
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        
    }
    
    func testAwakeFromNib() {
        let indexPath = IndexPath(row: 0, section: 0)
        let _ = createCell(indexPath: indexPath)

        // Write assertions for things you expect to happen in
        // awakeFromNib() method.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        let movie = Movie(popularity: 2, voteCount: 2, video: false, posterPath: "", id: 1, adult: false, backdropPath: "", originalLanguage: .en, originalTitle: "Avengers", genreIDS: [1], title: "Avenger", voteAverage: 5, overview: "The avengers movie", releaseDate: "2019")
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = createCell(indexPath: indexPath)
        
        measure {
            cell.movieItem = movie
        }
    }
    
    func testMoviesViewModel() {
        let movie = Movie(popularity: 2, voteCount: 2, video: false, posterPath: "", id: 1, adult: false, backdropPath: "", originalLanguage: .en, originalTitle: "Avengers", genreIDS: [1], title: "Avenger", voteAverage: 5, overview: "The avengers movie", releaseDate: "2019")
        let movieResponse = MovieResponseModel(page: 1, totalResults: 1, totalPages: 1, movie: [movie])
                
        XCTAssertEqual(movie.title, movieResponse.movie?.first?.title)
    }
    
    private class TableViewDataSource: NSObject, UITableViewDataSource {

    var items = [Movie]()

    override init() {
        super.init()

        let movie = Movie(popularity: 2, voteCount: 2, video: false, posterPath: "", id: 1, adult: false, backdropPath: "", originalLanguage: .en, originalTitle: "Avengers", genreIDS: [1], title: "Avenger", voteAverage: 5, overview: "The avengers movie", releaseDate: "2019")
        
        items.append(movie)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieViewCell",
                                                 for: indexPath)
        return cell
    }
    }

    private class TableViewDelegate: NSObject, UITableViewDelegate {

    }

}

extension MVVM_TemplateTests {

func createCell(indexPath: IndexPath) -> MovieViewCell {

    let cell = dataSource.tableView(tableView, cellForRowAt: indexPath) as! MovieViewCell
    XCTAssertNotNil(cell)

    let view = cell.contentView
    XCTAssertNotNil(view)

    return cell
}
}
