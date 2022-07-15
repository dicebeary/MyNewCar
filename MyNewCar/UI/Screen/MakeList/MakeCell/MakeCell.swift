import UIKit
import Kingfisher
import RxSwift
import RxCocoa

final class MakeCell: UITableViewCell {

    @IBOutlet private weak var makeImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    private var isFavorite: Bool = false {
        didSet {
            favoriteButton.setImage(isFavorite ? Constants.starFilledImage : Constants.starImage,
                                    for: .normal)
        }
    }
    
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        nameLabel.numberOfLines = 0
        favoriteButton.setTitle("", for: .normal)
    }
    
    func configureCell(_ make: MakeCellModel) {
        nameLabel.text = make.name
        makeImageView.kf.setImage(with: make.imageUrl)
        isFavorite = make.isFavorite
        
        favoriteButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.isFavorite = !self.isFavorite
            })
            .disposed(by: disposeBag)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    private enum Constants {
        static let starImage = UIImage(systemName: "star")
        static let starFilledImage = UIImage(systemName: "star.fill")
    }
}

// MARK: - EventProvider

extension MakeCell {
    struct Events {
        var favoriteDidTap: ControlEvent<Void>
    }
    
    var events: Events {
        return Events(favoriteDidTap: .init(events: favoriteButton.rx.tap))
    }
}
