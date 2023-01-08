//
//  TodayViewController+Action.swift
//  worder
//
//  Created by Misha Causur on 08.01.2023.
//

import Foundation.NSObject

extension TodayView {
    @objc internal func didTapDoneButton(_ sender: TodayCheckButton) {
        guard let id = sender.id else { return }
        completeItem(with: id)
    }
}
