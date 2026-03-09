//
//  ViewController.swift
//  Practice Project
//
//  Created by ambarish.shivakumar@Programming.com on 26/02/26.
//

import UIKit

class ViewController: UIViewController {

  
    override func viewDidLoad() {
        super.viewDidLoad()
    

        addCrown()
        //addFeature()
    }
    
    private func addCrown() {

        let crownVC = CrownControlViewController()

        addChild(crownVC)
        view.addSubview(crownVC.view)

        crownVC.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            crownVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            crownVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            crownVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            crownVC.view.heightAnchor.constraint(equalToConstant: 450)
        ])

        crownVC.didMove(toParent: self)
    }

}

//        let crownVC = CrownControlViewController()
//
//           addChild(crownVC)
//
//           view.addSubview(crownVC.view)
//
//           crownVC.view.translatesAutoresizingMaskIntoConstraints = false
//
//           NSLayoutConstraint.activate([
//               crownVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//               crownVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//               crownVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//               crownVC.view.heightAnchor.constraint(equalToConstant: 420)
//           ])
//
//           crownVC.didMove(toParent: self)




//      private func addFeature() {
//
//          let featureVC = featureViewController()
//
//          addChild(featureVC)
//          view.addSubview(featureVC.view)
//
//          featureVC.view.frame = CGRect(
//              x: 0,
//              y: view.frame.height/2,
//              width: view.frame.width,
//              height: view.frame.height
//          )
//
//          featureVC.didMove(toParent: self)
//      }
