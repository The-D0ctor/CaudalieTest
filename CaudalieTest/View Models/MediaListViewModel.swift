//
//  MediaListViewModel.swift
//  CaudalieTest
//
//  Created by Sébastien Rochelet on 31/05/2023.
//

import UIKit
import RxSwift
import RxRelay
import RxAlamofire

final class MediaListViewModel: NSObject {
    let medias = BehaviorRelay<[Media]>(value: [])
    static let url = "https://itunes.apple.com/search?"
    
    override init() {
        super.init()
    }
    
    func getMediaList(title: String?) {
        _ = RxAlamofire.request(.get, "\(MediaListViewModel.url)\((title != nil) ? "term=\((title?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!)" : "")")
            .responseData().expectingObject(ofType: GetMediaListResponse.self)
            .subscribe (onNext: { apiResult in
                switch apiResult {
                case let .success(getMediaListResponse):
                    self.medias.accept(getMediaListResponse.results)
                case let .failure(apiErrorMessage):
                    print(apiErrorMessage)
                }
            }, onError: { error in
                print(error)
            })
    }
}
