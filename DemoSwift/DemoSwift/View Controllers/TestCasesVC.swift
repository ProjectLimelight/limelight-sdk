//
//  TestCasesVC.swift
//  DemoSwift
//
// © 2026 Limelight Inc. All Rights Reserved.
//

import UIKit

// MARK: - TestCasesVC

final class TestCasesVC: UITableViewController {
    private var testCases: [String: [TestCase]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        testCases = TestCase.testCases
        tableView.reloadData()
        tableView.sectionHeaderTopPadding = 32
    }
}

// MARK: - UITableViewDataSource

extension TestCasesVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return testCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let testCaseSectionKey = TestCase.sectionKey(ofIndex: section) else { return 0 }
        return testCases[testCaseSectionKey]?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        guard
            let testCaseSectionKey = TestCase.sectionKey(ofIndex: indexPath.section),
            let testCaseSection = testCases[testCaseSectionKey]
        else { return cell }

        cell.textLabel?.text = testCaseSection[indexPath.row].title
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TestCasesVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard
            let testCaseSectionKey = TestCase.sectionKey(ofIndex: indexPath.section),
            let testCaseSection = testCases[testCaseSectionKey]
        else { return }
        
        // Create and configure UIViewController for testCase
        let vc = testCaseSection[indexPath.row].makeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let testCaseSectionKey = TestCase.sectionKey(ofIndex: section)
        return testCaseSectionKey
    }
}
