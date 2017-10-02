//
//  ConferenceDetailViewController.swift
//  amcios
//
//  Created by Matteo Crippa on 01/10/2017.
//  Copyright © 2017 Matteo Crippa. All rights reserved.
//

import UIKit
import MapKit

class ConferenceDetailViewController: BaseViewController {
    
    @IBOutlet weak var websiteButton: UIButton!
    
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var conference: Conference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set title
        title = conference?.title
        
        // set navigation
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.hidesBackButton = false
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.tintColor = .awesomeColor
        
        // set button tint
        websiteButton.tintColor = .awesomeColor
        
        // populate UI
        populateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

// MARK: - Data
extension ConferenceDetailViewController {
    func populateUI() {
        guard let conference = conference else { return }
        
        // set buttons
        websiteButton.setTitle(conference.homepage, for: .normal)
        
        // set labels
        startDateLabel.text = conference.startdate
        endDateLabel.text = conference.enddate
        countryLabel.text = conference.country
        
        // update map
        populateMap()
    }
    
    private func populateMap() {
        
    }
}

// MARK: - Action
extension ConferenceDetailViewController {
    @IBAction func openLink() {
        guard let conference = conference, let url = URL(string: conference.homepage) else { return }
        UIApplication.shared.open(url)
    }
}
