//
//  Extensions.swift
//  Practice Project
//
//  Created by Tharik Batcha on 04/03/26.
//

import UIKit


extension LanguageBottomSheetViewController: UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {

        viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "LanguageCell",
            for: indexPath
        ) as? LanguageCell else {
            return UITableViewCell()
        }

        cell.configure(with: viewModel.language(at: indexPath.row))

        return cell
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        let selectedLanguage = viewModel.language(at: indexPath.row)

        didSelectLanguage?(selectedLanguage)

        dismiss(animated: true)
    }

    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {

        guard let cell = cell as? LanguageCell else { return }

        let isLast =
        indexPath.row ==
        tableView.numberOfRows(inSection: indexPath.section) - 1

        cell.isLastCell = isLast
        cell.setNeedsLayout()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.searchText = textField.text ?? ""
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        showKeyboard()
        extendSheetToMax()
        return false
    }
}
