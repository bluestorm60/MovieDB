//
//  HomeViewModel.swift
//  MoveDB
//
//  Created by Ahmed Shafik on 02/01/2022.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel{
    let dispose = DisposeBag()
    let movies = PublishSubject<[MoviesPresentationDTO]>()
    let errorMsg = PublishSubject<String>()
    var pagingIndex = 1

    var homeApiManager: HomeServiceHandler!
    
    init(api: HomeServiceHandler) {
        self.homeApiManager = api
    }
    
    func getMovies(){
        homeApiManager.popularMoviesRequest(page: pagingIndex).observe(on: MainScheduler.instance).subscribe { [weak self](obj) in
            guard let self = self else {return}
            if obj.results.count != 0{
                self.movies.onNext(self.createPresentation(list: obj.results))
                return
            }
            self.errorMsg.onNext("Something went wrong")
        } onError: { [weak self](error) in
            guard let self = self else {return}
            self.errorMsg.onNext(error.localizedDescription)
        }.disposed(by: dispose)
    }

    //helpers
    func createPresentation(list: [MovieDataDTO]) -> [MoviesPresentationDTO] {
        let newList = list.map { item in
            return MoviesPresentationDTO(imgeString: item.posterPath, title: item.title)
        }
        return newList
    }
}
