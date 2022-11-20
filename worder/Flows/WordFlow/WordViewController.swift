//
//  WordViewController.swift
//  worder
//
//  Created by Misha Causur on 20.11.2022.
//

final class WordViewController: ViewController<WordView, WordViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.word.word
    }
}
