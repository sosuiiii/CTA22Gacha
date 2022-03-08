import RxCocoa
import RxSwift
import UIKit

class UpdateAndDeleteFooterView: UITableViewHeaderFooterView {
    @IBOutlet private weak var updateButton: UIButton!
    @IBOutlet private weak var deleteButton: UIButton!

    private var disposeBag = DisposeBag()
    func configure(viewStream: CreateGachaViewStreamType) {
        updateButton.rx.controlEvent(.touchUpInside)
            .bind(to: viewStream.input.updateButtonTapped)
            .disposed(by: disposeBag)

        deleteButton.rx.controlEvent(.touchUpInside)
            .bind(to: viewStream.input.deleteButtonTapped)
            .disposed(by: disposeBag)
    }
}
