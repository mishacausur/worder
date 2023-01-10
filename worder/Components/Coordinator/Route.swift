//
//  Route.swift
//  worder
//
//  Created by Misha Causur on 07.11.2022.
//

enum Route {
    case addWord
    case dismiss
    case details([WordModel])
    case word(WordModel)
    case todayDetail(Reminder, onChange: (Reminder) -> Void)
}
