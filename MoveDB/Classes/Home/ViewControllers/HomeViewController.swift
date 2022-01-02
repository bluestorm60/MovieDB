//
//  HomeViewController.swift
//  MoveDB
//
//  Created by Ahmed Shafik on 02/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    @IBOutlet weak var moviewListCollectionView: UICollectionView!{
        didSet{
            moviewListCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
            moviewListCollectionView.delegate = self
        }
    }
    
    private let spaceBetweenCells = 5.0
    private let dispose = DisposeBag()
    
    private var viewModel: HomeViewModel!
    
    
    //MARK: - App LifeCycle
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Popular Movies"
        configureBinding()
        viewModel.getMovies()
    }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellPadding = 25.0
        let width = (SCREEN_WIDTH - cellPadding) / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spaceBetweenCells
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spaceBetweenCells
    }
}


extension HomeViewController{
    private func configureBinding(){
        viewModel.movies.bind(to: self.moviewListCollectionView.rx.items(cellIdentifier: MovieCollectionViewCell.reuseIdentifier, cellType: MovieCollectionViewCell.self)){indexPath, item, cell in
            cell.item = item
        }.disposed(by: dispose)
        
        viewModel.errorMsg.observe(on: MainScheduler.instance).asObservable().subscribe { err in
            self.alert(alertTitle: "Error", msg: err)
        } .disposed(by: dispose)
    }
}
