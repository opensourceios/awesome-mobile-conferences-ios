//
//  ConferenceDetailTableViewCell.swift
//  amcios
//
//  Created by Matteo Crippa on 01/10/2017.
//  Copyright © 2017 Matteo Crippa. All rights reserved.
//

import UIKit

class ConferenceDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var conferenceFlag: UILabel!
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

    func setup(with conference: Conference) {
        self.conference = conference
        conferenceFlag.text = conference.emojiflag
        conferenceTitle.text = conference.title

        if conference.enddate != conference.startdate {
            conferenceDate.text = (conference.start?.toString(dateFormat: "dd") ?? "") + " - " + (conference.end?.toString(dateFormat: "dd") ?? "")
        } else {
            conferenceDate.text = conference.start?.toString(dateFormat: "dd") ?? ""
        }
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
        conferenceFavorite.isSelected = conference.isFavorite
    }
}
