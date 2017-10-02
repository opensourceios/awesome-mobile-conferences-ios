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

    private let geoCoder = CLGeocoder()

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

        // add gesture recognizer
        let tapOnMap = UITapGestureRecognizer(target: self, action: #selector(ConferenceDetailViewController.openMap(_:)))
        mapView.addGestureRecognizer(tapOnMap)

        // populate UI
        populateUI()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // update map
        populateMap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: - Data
extension ConferenceDetailViewController {
    fileprivate func populateUI() {
        guard let conference = conference else { return }

        // set buttons
        websiteButton.setTitle(conference.homepage, for: .normal)

        // set labels
        startDateLabel.text = conference.startdate
        endDateLabel.text = conference.enddate
        countryLabel.text = conference.country
    }

    fileprivate func populateMap() {
        guard let conference = conference else { return }
        getLocationFrom(address: conference.location)
    }
}

// MARK: - Action
extension ConferenceDetailViewController {
    @IBAction func openLink() {
        guard let conference = conference, let url = URL(string: conference.homepage) else { return }
        UIApplication.shared.open(url)
    }

    @objc func openMap(_ sender: UITapGestureRecognizer) {
        guard
            let conference = conference,
            let encodedAddress = conference.location.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let url = URL(string: "http://maps.apple.com/maps?saddr=\(encodedAddress)")
        else { return }
        UIApplication.shared.open(url)
    }
}

// MARK: - Map
extension ConferenceDetailViewController: MKMapViewDelegate {

    fileprivate func getLocationFrom(address: String) {
        geoCoder.geocodeAddressString(address) { (placemarks, _) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else { return }

            // center map
            self.centerMapOnLocation(location: location)

            // add annotation
            self.addAnnotationToMapAt(location: location)

        }
    }

    fileprivate func addAnnotationToMapAt(location: CLLocation) {
        // create marker
        let annotation = AwesomeAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)

        annotation.pinImage = "pin"

        // add marker
        mapView.addAnnotation(annotation)
    }

    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 400
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }

        if let customPointAnnotation = annotation as? AwesomeAnnotation {
            annotationView?.image = UIImage(named: customPointAnnotation.pinImage)
        }

        return annotationView
    }
}
