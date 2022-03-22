import RxCocoa
import RxSwift
import UIKit

final class CreateGachaViewController: UIViewController {

    private let viewStream: CreateGachaViewStreamType

    private let disposeBag = DisposeBag()
    init(viewStream: CreateGachaViewStreamType) {
        self.viewStream = viewStream
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemGray6

        let createGachaView = CreateGachaView(viewStream: viewStream)
        view.addSubview(createGachaView)
        createGachaView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createGachaView.topAnchor.constraint(equalTo: view.topAnchor),
            createGachaView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            createGachaView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            createGachaView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
