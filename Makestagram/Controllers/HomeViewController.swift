//
//  HomeViewController.swift
//  Makestagram
//
//  Created by Ben Botvinick on 7/11/18.
//  Copyright © 2018 Ben Botvinick. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // Mark: - Properties
    
    var posts = [Post]()
    
    @IBOutlet weak var tableView: UITableView!
    
    // Mark: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserService.posts(for: User.current) { (posts) in
            self.posts = posts
            self.tableView.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return posts.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostImageCell", for: indexPath)
        cell.backgroundColor = .red
        
        return cell
    }
}
