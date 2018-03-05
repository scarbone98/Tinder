//
//  CardsViewController.swift
//  Tinder
//
//  Created by Samuel Carbone on 3/4/18.
//  Copyright © 2018 Samuel Carbone. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var image: UIImageView!
    var cardInitialCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardInitialCenter = cardView.center
    }

    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        if sender.state == .began {
            cardInitialCenter = cardView.center
        } else if sender.state == .changed {
            cardView.transform = CGAffineTransform(translationX: translation.x, y: 0)
            cardView.transform = cardView.transform.rotated(by: CGFloat(Double(translation.x)/10 * Double.pi / 180))
        } else if sender.state == .ended {
            if translation.x > 50 {
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.cardView.transform = CGAffineTransform(translationX: velocity.x * 100, y: 0)
                }, completion: nil)
            }
            else{
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.cardView.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: nil)
            }
        }
    }
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "profileDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "profileDetails"){
            let profileDetails = segue.destination as! ProfileViewController
            profileDetails.image = self.image.image
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
