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

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textFieldSectionView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textViewSectionView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var pickerSectionView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!

    private(set) var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    func configureCell(data: MockGachaData, type: CreateGachaSectionType) {
        titleLabel.text = data.sectionTitle

        pickerView.dataSource = self
        pickerView.delegate = self

        textFieldSectionView.isHidden = type != .textField
        textViewSectionView.isHidden = type != .textView
        pickerSectionView.isHidden = type != .pickerView
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
