//
//  GachaListViewController.swift
//  GachaApp
//
//  Created by 化田晃平 on 2022/03/05.
//

import PKHUD
import RxCocoa
import RxSwift
import UIKit

final class GachaListViewController: UIViewController {
    @IBOutlet private weak var segmentControl: UISegmentedControl! {
        didSet {
            segmentControl.setTitle(L10n.allGacha, forSegmentAt: 0)
            segmentControl.setTitle(L10n.myGacha, forSegmentAt: 1)
        }
    }
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.registerNib(GachasTableViewCell.self)
            refreshControl.layer.opacity = 0
            tableView.refreshControl = refreshControl
            tableView.rowHeight = 100
        }
    }

    private let viewStream: GachaListViewStreamType
    private let disposeBag = DisposeBag()

    private let refreshControl = UIRefreshControl()

    init(viewStream: GachaListViewStreamType = GachaListViewStream()) {
        self.viewStream = viewStream
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar(withTitle: L10n.gachaAppTitle)
        // Do any additional setup after loading the view.

        tableView.refreshControl?.rx.controlEvent(.valueChanged)
            .map { _ in }
            .bind(to: viewStream.input.refresh)
            .disposed(by: disposeBag)

        segmentControl.rx.selectedSegmentIndex
            .bind(to: viewStream.input.segmentIndex)
            .disposed(by: disposeBag)

        viewStream.output.gachaList
            .bind(to: tableView.rx.items(
                cellIdentifier: GachasTableViewCell.className,
                cellType: GachasTableViewCell.self
            )) { _, gacha, cell in
                cell.configure(with: gacha)
            }
            .disposed(by: disposeBag)

        viewStream.output.isConnecting
            .filter { $0 == true }
            .map { _ in }
            .bind(to: Binder(self) { _, _ in HUD.show(.progress) })
            .disposed(by: disposeBag)

        viewStream.output.isConnecting
            .filter { $0 == false }
            .map { _ in }
            .bind(to:
                refreshControl.rx.endRefreshing,
                Binder(self) { _, _ in HUD.hide() }
            )
            .disposed(by: disposeBag)

        viewStream.output.error
            .do(onNext: { error in
                HUD.show(.labeledError(title: L10n.connectedError, subtitle: error.localizedDescription))
            })
            .delay(.seconds(2), scheduler: MainScheduler.instance)
            .do(onNext: { _ in
                HUD.hide()
            })
            .subscribe()
            .disposed(by: disposeBag)

        // viewDidLoadをviewStreamに通知
        Observable.just(())
            .bind(to:viewStream.input.viewDidLoad)
            .disposed(by: disposeBag)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
