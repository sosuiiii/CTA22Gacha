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
            segmentControl.setTitle(L10n.allGacha, forSegmentAt: GachaListViewStream.SCTag.allGacha.rawValue)
            segmentControl.setTitle(L10n.myGacha, forSegmentAt: GachaListViewStream.SCTag.myGacha.rawValue)
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

    @IBOutlet private weak var addGachaButton: UIButton! {
        didSet {
            addGachaButton.setTitle(L10n.gachaAddGacha, for: .normal)
            addGachaButton.layer.cornerRadius = 5
        }
    }

    private let viewStream: GachaListViewStreamType

    private let dataSource = GachasListDataSource()
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

        addGachaButton.rx.tap
            .map(void)
            .bind(to: viewStream.input.addGacha)
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(Gacha.self)
            .bind(to: viewStream.input.showGachaDetail)
            .disposed(by: disposeBag)

        tableView.refreshControl?.rx.controlEvent(.valueChanged)
            .map(void)
            .bind(to: viewStream.input.refresh)
            .disposed(by: disposeBag)

        dataSource.rotateGacha
            .bind(to: viewStream.input.rotateGacha)
            .disposed(by: disposeBag)

        segmentControl.rx.selectedSegmentIndex
            .bind(to: viewStream.input.segmentIndex)
            .disposed(by: disposeBag)

        viewStream.output.gachaList
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewStream.output.isConnecting
            .filter { $0 == true }
            .map(void)
            .bind(to: Binder(self) { _, _ in HUD.show(.progress) })
            .disposed(by: disposeBag)

        viewStream.output.isConnecting
            .filter { $0 == false }
            .map(void)
            .bind(to:
                refreshControl.rx.endRefreshing,
                Binder(self) { _, _ in HUD.hide() }
            )
            .disposed(by: disposeBag)

        viewStream.output.error
            .do { error in
                HUD.show(.labeledError(title: L10n.connectedError, subtitle: error.localizedDescription))
            }
            .delay(.seconds(2), scheduler: MainScheduler.instance)
            .do { _ in
                HUD.hide()
            }
            .subscribe()
            .disposed(by: disposeBag)

        // TODO: ガチャ追加画面遷移
        viewStream.output.transitionState
            .do { transitionState in
                switch transitionState {
                case .addGacha:
                    print("ガチャ追加画面へ")
                case .rotate(let gacha):
                    print("[\(gacha.name)]ガチャを回す画面へ")
                case .showDetail(let gacha):
                    print("[\(gacha.name)]ガチャの詳細へ")
                }
            }
            .subscribe()
            .disposed(by: disposeBag)

        // viewDidLoadをviewStreamに通知
        Observable.just(())
            .bind(to:viewStream.input.viewDidLoad)
            .disposed(by: disposeBag)

    }
}
