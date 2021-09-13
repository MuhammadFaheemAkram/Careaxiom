//
//  HomeViewController.swift
//  Careaxiom
//
//  Created by BrainX IOS 3 on 13/09/2021.
//

import UIKit

enum HomeRouteType: RouteType {
    case Home(data: Any? = nil)
}

class HomeViewController: BaseViewController {
	
	// MARK: - Outlets

	@IBOutlet var homeView: HomeView!

	// MARK: - Instance variables
	
	private var homeViewModel: HomeViewModel!
	
	// MARK: - Init Methods

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		let router = HomeRouter(viewController: self)
		homeViewModel = HomeViewModel(router: router)
	}

	// MARK: - Override Methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupTableView()
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		fetchStories()
	}
	
	// MARK: - Private Methods
	
	private func setupTableView() {
		homeView.tableView.dataSource = self
		homeView.tableView.delegate = self
	}
	
	private func fetchStories(){
		homeViewModel.fetchStories(withCompletion: {
			self.homeView.tableView.reloadData()
		})
	}
}

// MARK: - UITableView DataSource Methods

extension HomeViewController: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return homeViewModel.storyKeys.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let arrayAtIndex = homeViewModel.storyGroup[homeViewModel.storyKeys[section]]
		return arrayAtIndex?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return String(homeViewModel.storyKeys[section])
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let listForSection = homeViewModel.storyGroup[homeViewModel.storyKeys[indexPath.section]] else {
			return UITableViewCell()
		}
		let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedTableViewCell") as! NewsFeedTableViewCell
		cell.setData(story: listForSection[indexPath.row])
		return cell
		
	}
	
}

// MARK: - UITableView Delegate Methods

extension HomeViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}

