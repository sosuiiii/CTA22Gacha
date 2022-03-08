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
                cell.configureCell(viewStream: viewStream, data: items, indexPath: indexPath)
                switch indexPath.row % 7 {
                case 0:
                    cell.configureType(type: .textField)
                case 1:
                    cell.configureType(type: .textView)
                case 2:
                    cell.configureType(type: .pickerView)
                case 3:
                    cell.configureType(type: .textField)
                case 4:
                    cell.configureType(type: .textField)
                default:
                    break
                }

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
