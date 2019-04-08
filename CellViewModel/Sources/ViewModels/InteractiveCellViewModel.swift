//
//  InteractiveCellViewModel.swift
//  VoucherPay
//
//  Created by Anton Poltoratskyi on 03.04.2019.
//  Copyright © 2019 andersen. All rights reserved.
//

protocol InteractiveCellViewModel {
    var selectionHandler: () -> Void { get }
}
