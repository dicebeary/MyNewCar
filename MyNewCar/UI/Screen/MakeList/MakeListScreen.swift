import UIKit
import Resolver
import RxSwift
import RxRelay
import RxCocoa

final class MakeListScreen: UIViewController {
    @Injected private var viewModel: MakeListViewModel
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let favoriteDidTap = PublishRelay<String>()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        setupTableView()
        
        viewModel.listen(to: self.events)
        
        viewModel.list
            .bind(to: tableView.rx.items(cellIdentifier: MakeCell.identifier,
                                         cellType: MakeCell.self)) { [weak self] _, model, cell in
                guard let self = self else { return }
                cell.configureCell(model)
                cell.events.favoriteDidTap
                    .map { model.id }
                    .bind(to: self.favoriteDidTap)
                    .disposed(by: cell.disposeBag)
            }.disposed(by: disposeBag)
    }
}

// MARK: Setup TableView

extension MakeListScreen {
    func setupTableView() {
        tableView.register(MakeCell.nib, forCellReuseIdentifier: MakeCell.identifier)
    }
}

// MARK: - EventProvider

extension MakeListScreen {
    struct Events {
        var favoriteDidTap: ControlEvent<String>
    }
    
    var events: Events {
        return Events(favoriteDidTap: .init(events: favoriteDidTap.asObservable()))
    }
}
