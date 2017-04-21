//
//  ViewController.swift
//  Diagonal
//
//  Created by Vaishakh on 4/20/17.
//  Copyright © 2017 Vaishakh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MovieCentreDatasourceDelegate {
    
    
    var movieList: [MovieModel]?
    @IBOutlet weak var collectionView: UICollectionView!
    private var flowLayout = UICollectionViewFlowLayout()
    private var dataSource: MovieCentreDatasource!
    var page: Int = 1
    var isMovieListLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setupCollectionView()
        loadNewMoviesList()
    }
    
    func initUI() {
        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: "nav_bar")?.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
        self.view.setNeedsLayout()
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
    }
    
    
    func setupCollectionView() {
        
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        if #available(iOS 9, *) {
            flowLayout.sectionHeadersPinToVisibleBounds = true
        }
        dataSource = MovieCentreDatasource.init(delegate: self)
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        collectionView.alwaysBounceVertical = true
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView.collectionViewLayout = flowLayout
        
    }
    
    
    func loadNewMoviesList() {
        
        if !isMovieListLoading {
            isMovieListLoading = true
            // Network Manager is used which can be used in future for Network calls directly
            NetworkManager.sharedInstance.getMovieListForPage(page: page) { (responseMovieList, error) in
                if error != nil {
                    print("Load Movie Error : \(error?.localizedDescription)")
                    return
                }
                guard let movieList = responseMovieList, movieList.count > 0 else {
                    print("No more Data to add")
                    return
                }
                if self.dataSource.movieList.count > 0 {
                    self.dataSource.movieList.append(contentsOf: movieList)
                } else {
                    self.dataSource.movieList = movieList
                }
                self.page += 1
                self.collectionView.dataSource = self.dataSource
                self.collectionView.delegate = self.dataSource
                self.isMovieListLoading = false
                self.collectionView.reloadData()
            }
        }

    }
    
    // Mark: MovieDataSourceDeleagte
    func reloadData() {
        
        if self.page <= GlobalConstants.totalNumPages {
            loadNewMoviesList()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

