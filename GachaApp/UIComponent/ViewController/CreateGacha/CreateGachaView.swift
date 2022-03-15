import RxCocoa
import RxDataSources
import RxSwift
import UIKit

struct MockGachaData {
    let sectionTitle: String
    let description: String?
    let rarelity: String?
    let createrName: String?
    let createrID: String?
    init(
        sectionTitle: String,
        description: String? = nil,
        rarelity: String? = nil,
        creatorName: String? = nil,
        creatorID: String? = nil
    ) {
        self.sectionTitle = sectionTitle
        self.description = description
        self.rarelity = rarelity
        self.createrName = creatorName
        self.createrID = creatorID
    }
}
struct MockGachaDataSource {
//    var headerTitle: String
    var items: [MockGachaData]
//    var footerTitle: String
}
extension MockGachaDataSource: SectionModelType {
    init(original: MockGachaDataSource, items: [MockGachaData]) {
        self = original
        self.items = items
    }
}

final class CreateGachaView: UIView {

    private let tableView = UITableView()
    private var datasource: RxTableViewSectionedReloadDataSource<MockGachaDataSource>?
    private let viewStream: CreateGachaViewStreamType
    private let disposeBag = DisposeBag()
    init(viewStream: CreateGachaViewStreamType) {
        self.viewStream = viewStream
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        clipsToBounds = true
        addSubviews()
        setLayout()

        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = .systemGray6
        tableView.register(UINib(nibName: String(describing: CreateGachaTableViewCell.self), bundle: nil), forCellReuseIdentifier: "cell")
        tableView.register(UINib(nibName: String(describing: UpdateAndDeleteFooterView.self), bundle: nil), forHeaderFooterViewReuseIdentifier: "UpdateAndDeleteFooterView")
        tableView.delegate = self

        datasource = RxTableViewSectionedReloadDataSource<MockGachaDataSource>(
            configureCell: { _, tableView, indexPath, items in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CreateGachaTableViewCell else {
                    return UITableViewCell()
                }

                switch indexPath.row % 5 {
                case 0:
                    cell.configureCell(data: items, type: .textField)
                case 1:
                    cell.configureCell(data: items, type: .textView)
                case 2:
                    cell.configureCell(data: items, type: .pickerView)
                case 3:
                    cell.configureCell(data: items, type: .textField)
                case 4:
                    cell.configureCell(data: items, type: .textField)
                default:
                    break
                }
                cell.pickerView.rx.itemSelected
                    .subscribe(onNext: { pickerIndexPath in
                        viewStream.input.pickerView.onNext((pickerIndexPath, indexPath))
                    }).disposed(by: cell.disposeBag)

                cell.textField.rx.text.orEmpty
                    .subscribe(onNext: { text in
                        viewStream.input.textField.onNext((text, indexPath))
                    }).disposed(by: cell.disposeBag)

                cell.textView.rx.text.orEmpty
                    .subscribe(onNext: { text in
                        viewStream.input.textView.onNext((text, indexPath))
                    }).disposed(by: cell.disposeBag)

                return cell
            })

        viewStream.output.datasource
            .bind(to: tableView.rx.items(dataSource: datasource!))
            .disposed(by: disposeBag)
    }
    private func addSubviews() {
        addSubview(tableView)
    }

    private func setLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CreateGachaView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "UpdateAndDeleteFooterView") as? UpdateAndDeleteFooterView else {
            return UIView()
        }
        footer.configure(viewStream: viewStream)
        return footer
    }
}
