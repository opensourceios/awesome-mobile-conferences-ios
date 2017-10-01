//
//  ConferenceDetailViewController.swift
//  amcios
//
//  Created by Matteo Crippa on 01/10/2017.
//  Copyright © 2017 Matteo Crippa. All rights reserved.
//

import UIKit

class ConferenceDetailViewController: BaseViewController {
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
