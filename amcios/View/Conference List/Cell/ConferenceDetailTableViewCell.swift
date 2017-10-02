//
//  ConferenceDetailTableViewCell.swift
//  amcios
//
//  Created by Matteo Crippa on 01/10/2017.
//  Copyright © 2017 Matteo Crippa. All rights reserved.
//

import UIKit

class ConferenceDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var conferenceTitle: UILabel!
    @IBOutlet weak var conferenceDate: UILabel!
    @IBOutlet weak var conferenceFavorite: UIButton!

    private var conference: Conference?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(with conference: Conference, remove: Int) {
        self.conference = conference
        conferenceTitle.text = conference.title
        conferenceDate.text = conference.startdate.replacingOccurrences(of: "\(remove)/", with: "")
        conferenceFavorite.tintColor = .awesomeColor
        updateButtonUI()
    }

    @IBAction func triggerFavorite() {
        guard let conference = conference else { return }
        self.conference?.isFavorite = !conference.isFavorite
        updateButtonUI()
    }

    private func updateButtonUI() {
        guard let conference = conference else { return }
        conferenceFavorite.alpha = conference.isFavorite ? 1.0 : 0.5
    }
}
