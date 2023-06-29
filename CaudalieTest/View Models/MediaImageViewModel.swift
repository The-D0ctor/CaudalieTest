//
//  MediaImageViewModel.swift
//  CaudalieTest
//
//  Created by Sébastien Rochelet on 31/05/2023.
//

import UIKit
import RxSwift
import RxRelay
import RxAlamofire

final class MediaImageViewModel: NSObject {
    let image = BehaviorRelay<UIImage?>(value: UIImage())
    
    override init() {
        super.init()
    }
    
    func getImage(imageUrl: String) {
        _ = RxAlamofire.request(.get, imageUrl)
            .responseData()
            .subscribe (onNext: { [weak self] (r, imagedata) in
                self?.image.accept(UIImage(data: imagedata))
            }, onError: { error in
                print(error)
            })
    }
}
