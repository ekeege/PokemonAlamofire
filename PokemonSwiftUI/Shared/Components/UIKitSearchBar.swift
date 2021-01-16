//
//  UIKitSearchBar.swift
//  PokemonSwiftUI
//
//  Created by Ege Eke on 16.01.2021.
//

import SwiftUI

class UIKitSearchBar: NSObject, ObservableObject {
    @Published var text: String = ""
    let searchController = UISearchController(searchResultsController: nil)
    override init() {
        super.init()
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.definesPresentationContext = true
        self.searchController.searchResultsUpdater = self
    }
}

extension UIKitSearchBar: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // Publish search bar text changes.
        if let searchBarText = searchController.searchBar.text {
            self.text = searchBarText
        }
    }
}

struct SearchBarModifier: ViewModifier {
    let searchBar: UIKitSearchBar
    func body(content: Content) -> some View {
        content
            .overlay(
                ViewControllerResolver { viewController in
                    viewController.navigationItem.searchController = self.searchBar.searchController
                }
                .frame(width: 0, height: 0)
            )
    }
}

extension View {
    func add(_ searchBar: UIKitSearchBar) -> some View {
        return self.modifier(SearchBarModifier(searchBar: searchBar))
    }
}

final class ViewControllerResolver: UIViewControllerRepresentable {
    let onResolve: (UIViewController) -> Void
    init(onResolve: @escaping (UIViewController) -> Void) {
        self.onResolve = onResolve
    }
    func makeUIViewController(context: Context) -> ParentResolverViewController {
        ParentResolverViewController(onResolve: onResolve)
    }
    func updateUIViewController(_ uiViewController: ParentResolverViewController, context: Context) { }
}

class ParentResolverViewController: UIViewController {
    let onResolve: (UIViewController) -> Void
    init(onResolve: @escaping (UIViewController) -> Void) {
        self.onResolve = onResolve
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if let parent = parent {
            onResolve(parent)
        }
    }
}
