//
//  ConferenceListViewController.swift
//  amcios
//
//  Created by Matteo Crippa on 01/10/2017.
//  Copyright © 2017 Matteo Crippa. All rights reserved.
//

import UIKit
import Exteptional

class ConferenceListViewController: BaseViewController {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var filterItems: UISegmentedControl!
    
    // type of the list
    fileprivate enum listType {
        case all
        case favorite
    }
    
    fileprivate var conferences: [Conference]? {
        didSet {
            table.reloadData()
        }
    }
    fileprivate var filteredConferences: [Conference]? {
        didSet {
            table.reloadData()
        }
    }
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .awesomeColor
        refreshControl.addTarget(self, action: #selector(ConferenceListViewController.getRemoteData), for: .valueChanged)
        return refreshControl
    }()
    fileprivate var isSearchActive: Bool {
        return (searchController.isActive && searchController.searchBar.text != "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Filter"
        searchController.searchBar.tintColor = .awesomeColor
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        
        title = "Conferences"
        
        // add refresh control
        table.refreshControl = refreshControl
        
        // set extra stuff for navigation bar
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.hidesBackButton = false
        navigationItem.largeTitleDisplayMode = .always
        
        // set tint of selector
        filterItems.tintColor = .awesomeColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getRemoteData()
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? ConferenceDetailViewController else { return }
        //vc.conference = conferences[table]
    }
    
}

// MARK: - Networking
extension ConferenceListViewController {
    
    fileprivate func parseJson(from data: Data) {
        do {
            let decoded = try JSONDecoder().decode(Awesome.self, from: data)
            MemoryDb.shared.data = decoded
            // get all results for root
            conferences = getResults()
            //print("👨‍💻 decoded:", decoded)
        } catch (let error) {
            print("🙅 \(error)")
        }
    }
    
    @objc fileprivate func getRemoteData() {
        
        // start refreshing
        refreshControl.beginRefreshing()
        
        // show latest update
        let lastUpdate = "⏱ last update: \(MemoryDb.shared.lastUpdate.toString(dateFormat: "dd/MM/yyyy @ HH:mm"))"
        refreshControl.attributedTitle = NSAttributedString(string: lastUpdate)
        
        // retrieve data from remote
        if let data = AMCApi.getData() {
            // parse json
            parseJson(from: data)
            
            // stop refreshing
            refreshControl.endRefreshing()
        }
        
    }
}

// MARK: - Database (Memory)
extension ConferenceListViewController {
    
    func getResults() -> [Conference]? {
        if let data = MemoryDb.shared.data {
             // sort by start date
             return data.conferences.sorted(by: {(a,b) -> Bool in
                return a.start! < b.start!
             })
        }
        return nil
    }
    
}

// MARK: - UISearchBar Delegate
extension ConferenceListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        // check if search is active
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            // force clear the results first
            filteredConferences?.removeAll()
            
            // populate filtered results
            filteredConferences = MemoryDb.shared.data?.conferences.filter({ conf -> Bool in
                return conf.title.lowercased().contains(searchText.lowercased()) ||
                    conf.location.lowercased().contains(searchText.lowercased())
            })
        }
        
    }
}

// MARK: Actions
extension ConferenceListViewController {
    @IBAction func changeFilterItems(sender: UISegmentedControl) {
        //print(sender.selectedSegmentIndex)
        // reload table
        table.reloadData()
    }
}

// MARK: - Data source
extension ConferenceListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // TODO: count years
        return MemoryDb.shared.data?.years.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let year = MemoryDb.shared.data?.years[section] else { return 0 }
        
        return conferences?.filter({ conf -> Bool in
            return conf.year == year
        }).count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "conferenceCell") as! ConferenceDetailTableViewCell
        
        let year = MemoryDb.shared.data?.years[indexPath.section]
        let yearConf = conferences?.filter({ conf -> Bool in
            return conf.year == year
        })
        
        cell.setup(with: yearConf![indexPath.row], remove: year ?? 0)
        return cell
    }
}

// MARK: - Table delegate
extension ConferenceListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let year = MemoryDb.shared.data?.years[section] ?? 0
        return "\(year)"
    }
}
