//
//  MovieTableViewController.swift
//  Movie List
//
//  Created by Rebecca Overare on 5/15/20.
//  Copyright © 2020 Rebecca Overare. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {

    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell else {
            fatalError("Cell identifier is wrong or the cell is not of expected type FriendTableViewCell")
        }
            let movie = movies[indexPath.row]
            cell.movieLabel.text = movie.name
        return cell
    }
    


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            movies.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
     

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let movedItem = movies[sourceIndexPath.item]
        movies.remove(at: sourceIndexPath.item)
        movies.insert(movedItem, at: destinationIndexPath.item)
    }
    
    
    @IBAction func edit(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
        sender.title = (tableView.isEditing) ? "Done" : "Edit"
    }
    

    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddMovieSegue" {
            let addVC = segue.destination as? AddMovieViewController
            addVC?.delegate = self
            dismiss(animated: true, completion: nil)
        }
    }
}

extension MovieTableViewController: MovieDelegate {
    func movieWasAdded(movie: Movie) {
        movies.append(movie)
        tableView.reloadData()
    }
}

