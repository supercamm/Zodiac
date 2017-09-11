//  ViewController.swift
//  ZodiacV4

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: - program outlets
    @IBOutlet weak var mainViewLabel: UILabel!
    @IBOutlet weak var popUpViewLabel: UILabel!
    @IBOutlet weak var popUpViewImage: UIImageView!
    @IBOutlet weak var popUpSignLabel: UILabel!
    @IBOutlet weak var popUpViewText: UITextView!
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var pagingDotsImageView: UIImageView!
    @IBAction func closePopUp(_ sender: Any) {
        animateOut()
    }
    
    // MARK: - program vars
    var currentString : String!
    let reuseIdentifier = "cell"
    
    // MARK: - program functions
    override func viewDidLoad() {
        super.viewDidLoad()
        //Gesture code
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector((handleSwipes)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector((handleSwipes)))
        //Gesture code
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        //Gesture code
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    //Gesture code
    func handleSwipes(_sender: UISwipeGestureRecognizer) {
        if (_sender.direction == .left ) {
            mainViewLabel.text = "Characteristics"
            pagingDotsImageView.image = UIImage(named: "dots2")
        }
        if (_sender.direction == .right ) {
            mainViewLabel.text = "Daily"
            pagingDotsImageView.image = UIImage(named: "dots1")
        }
    }
    
    //Animate the popUp out
    func animateOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.popUpView.alpha = 0
        }) {(success:Bool)in
            self.popUpView.removeFromSuperview()
        }
    }
    
    //Animate the popUp in
    func animateIn() {
        self.view.addSubview(popUpView)
        popUpView.center = self.view.center
        popUpView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        popUpView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.popUpView.alpha = 1
            self.popUpView.transform = CGAffineTransform.identity
        }
        //on animation call setPopUp func
        setPopUp(_sign: currentString, _headerLabel: mainViewLabel.text!)
    }
    
    //Layout attributes for the popUp View
    func setPopUp(_sign: String, _headerLabel: String) {
        popUpViewLabel.text = mainViewLabel.text
        popUpViewImage.image = UIImage(named: _sign)
        popUpSignLabel.text = _sign
        
        //Determine which label to display
        var index : Int!
        if (_headerLabel == "Characteristics") { index = 1 } else { index = 0 }
        
        //Pull correct text from codeBase array
        var tempText : String!
        tempText = codeBase[_sign]?[index]
        popUpViewText.text = tempText
        popUpViewText.isEditable = false
    }
    
    // MARK: - UICollectionViewDataSource protocol - tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return signs.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.myLabel.text = signs[indexPath.item]
        cell.myImageView.image = UIImage(named: signs[indexPath.item])
        
        //Cell attributes to change the look
        cell.layer.cornerRadius = 3
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.masksToBounds = true
        return cell
    }
    
    // animate popUp when user touches cell
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath){
    currentString = signs[indexPath.item]
        animateIn()
    }



}

