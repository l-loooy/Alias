//
//  AvatarViewController.swift
//  Alias 3.0
//
//  Created by admin on 06.05.2022.
//  Copyright © 2022 Sergey Lolaev. All rights reserved.
//

import UIKit

protocol AddSelectedAvatarToTableView {
    func addThisAvatar(_ avatar: UIImage)
}

class AvatarViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var images = [UIImage]()
    var delegate: AddSelectedAvatarToTableView?
    var selectedIndexPath: IndexPath?
    
    var didTapDoneButtonAction: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        for i in 1...5 {
            let image = UIImage(named:"\(i)")!
            images.append(image)
        }
    }
    
    @IBAction func goBackToRegistrationVC(_ sender: UIButton) {
        if let selectedIndexPath = selectedIndexPath {
            let myAvatar = images[selectedIndexPath.row]
            delegate?.addThisAvatar(myAvatar)
            print(myAvatar)
        }
        
        self.dismiss(animated: true) { [weak self] in
            self?.didTapDoneButtonAction?()
        }
    }
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension AvatarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! AvatarCollectionViewCell
        let myAvatar = images[indexPath.row]
        cell.avatar.image = myAvatar
        delegate?.addThisAvatar(myAvatar)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        deselectCell(collectionView)
        selectCell(collectionView, indexPath: indexPath)
    }
    
    private func selectCell(_ collectionView: UICollectionView, indexPath: IndexPath) {
        selectedIndexPath = indexPath
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 4.0
        cell?.layer.borderColor = UIColor.white.cgColor
    }
    
    private func deselectCell(_ collectionView: UICollectionView) {
        guard let selectedIndexPath = selectedIndexPath else {return}
        let cell = collectionView.cellForItem(at: selectedIndexPath)
        cell?.layer.borderWidth = 0.0
        cell?.layer.borderColor = UIColor.white.cgColor
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AvatarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = collectionView.frame
        let widthCell = frameCV.width / CGFloat(images.count)
        let heightCell = widthCell
        return CGSize(width: widthCell, height: heightCell)
    }
}
