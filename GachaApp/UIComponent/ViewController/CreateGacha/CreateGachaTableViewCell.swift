//
//  CreateGachaTableViewCell.swift
//  GachaApp
//
//  Created by 田中 颯志 on 2022/03/07.
//

import RxRelay
import RxSwift
import UIKit

enum CreateGachaSectionType: Equatable {
    case textField
    case textView
    case pickerView
}

class CreateGachaTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textFieldSectionView: UIView!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var textViewSectionView: UIView!
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var pickerSectionView: UIView!
    @IBOutlet private weak var pickerView: UIPickerView!

    private var type: CreateGachaSectionType?
    private(set) var indexPath = PublishRelay<IndexPath>()
    private(set) var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        disposeBag = DisposeBag()
        if let type = type {
            hidden(type: type)
        }
    }

    func configureType(type: CreateGachaSectionType) {
        self.type = type
        hidden(type: type)
    }
    func configureCell(viewStream: CreateGachaViewStreamType, data: MockGachaData, indexPath: IndexPath) {
        titleLabel.text = data.sectionTitle
        self.indexPath.accept(indexPath)

        pickerView.dataSource = self
        pickerView.delegate = self

        pickerView.rx.itemSelected
            .subscribe(onNext: { pickerIndexPath in
                viewStream.input.pickerView.onNext((pickerIndexPath, indexPath))
            }).disposed(by: disposeBag)

        textField.rx.text.orEmpty
            .subscribe(onNext: { text in
                viewStream.input.textField.onNext((text, indexPath))
            }).disposed(by: disposeBag)

        textView.rx.text.orEmpty
            .subscribe(onNext: { text in
                viewStream.input.textView.onNext((text, indexPath))
            }).disposed(by: disposeBag)

    }
    private func hidden(type: CreateGachaSectionType) {
        textFieldSectionView.isHidden =
            type == .textField ? false : true
        textViewSectionView.isHidden =
            type == .textView ? false : true
        pickerSectionView.isHidden =
            type == .pickerView ? false : true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension CreateGachaTableViewCell: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        CreateGachaViewStream.Const.gachaRarity.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // TODO: モデルに移す
        return CreateGachaViewStream.Const.gachaRarity[row]
    }
}
