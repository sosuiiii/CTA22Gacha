//
//  GachasTableViewCell.swift
//  GachaApp
//
//  Created by 化田晃平 on 2022/03/05.
//

import RxSwift
import UIKit

final class GachasTableViewCell: UITableViewCell {

    @IBOutlet private(set) weak var rotateButton: UIButton! {
        didSet {
            rotateButton.setTitle(L10n.gachaRotate, for: .normal)
            rotateButton.layer.cornerRadius = 5
        }
    }

    @IBOutlet private weak var gachaImageView: UIImageView! {
        didSet {
            gachaImageView.image = UIImage(systemName: "pencil")
        }
    }
    
    private(set) var disposeBag = DisposeBag()

    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with gacha: Gacha) {
    }
}
