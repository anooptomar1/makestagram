//
//  HomeViewController.swift
//  Makestagram
//
//  Created by Ben Botvinick on 7/11/18.
//  Copyright © 2018 Ben Botvinick. All rights reserved.
//

import UIKit
import Kingfisher

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
        
        configureTableView()
    }
    
    func configureTableView() {
        // remove separators for empty cells
        tableView.tableFooterView = UIView()
        // remove separators from cells
        tableView.separatorStyle = .none
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.section]
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostHeaderCell") as! PostHeaderCell
            cell.usernameLabel.text = User.current.username
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostImageCell") as! PostImageCell
            let imageURL = URL(string: post.imageURL)
            cell.postImageView.kf.setImage(with: imageURL)
            cell.postTagsLabel.text = post.tags[0]
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostActionCell") as! PostActionCell
            
            return cell
            
        default:
            fatalError("Error: unexpected indexPath.")
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return PostHeaderCell.height
            
        case 1:
            let post = posts[indexPath.section]
            return post.imageHeight
            
        case 2:
            return PostActionCell.height
            
        default:
            fatalError()
        }
    }
}
