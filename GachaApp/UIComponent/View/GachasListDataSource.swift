//
//  GachasListDataSource.swift
//  GachaApp
//
//  Created by 化田晃平 on 2022/03/06.
//

import RxCocoa
import RxSwift
import UIKit

final class GachasListDataSource: NSObject, UITableViewDataSource {

    typealias Element = [Gacha]
    private var items: Element = []

    private let rotateGachaRelay = PublishRelay<Gacha>()
    var rotateGacha: Observable<Gacha> {
        rotateGachaRelay.asObservable()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(GachasTableViewCell.self, for: indexPath)
        let gacha = items[indexPath.item]
        cell.configure(with: gacha)

        cell.rotateButton.rx.tap
            .map { _ in gacha }
            .bind(to: rotateGachaRelay)
            .disposed(by: cell.disposeBag) // セルがdisposeBag持たないと購読が重複する。

        return cell
    }
}

extension GachasListDataSource: RxTableViewDataSourceType {
    func tableView(_ tableView: UITableView, observedEvent: Event<[Gacha]>) {
        Binder(self) { dataSource, gachas in
            dataSource.items = gachas
            tableView.reloadData()
        }.on(observedEvent)
    }
}

extension GachasListDataSource: SectionedViewDataSourceType {
    func model(at indexPath: IndexPath) throws -> Any {
        items[indexPath.item]
    }
}
