//
//  GachasTableViewCell.swift
//  GachaApp
//
//  Created by 化田晃平 on 2022/03/05.
//

import UIKit

final class GachasTableViewCell: UITableViewCell {

    @IBOutlet private weak var gachaImageView: UIImageView! {
        didSet {
            gachaImageView.image = UIImage(systemName: "pencil")
        }
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
