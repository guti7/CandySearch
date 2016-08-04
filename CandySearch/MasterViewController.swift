/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class MasterViewController: UITableViewController, UISearchResultsUpdating {
  
  // MARK: - Properties

    var detailViewController: DetailViewController? = nil
    var candies = [Candy]()
    let searchController = UISearchController(searchResultsController: nil)
    // array matching search string for Candy.name
    var filteredCandies = [Candy]()
  
  // MARK: - View Setup
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Set up UI for sarchControoler
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false // TODO: true?
    definesPresentationContext = true // TODO: false?
    tableView.tableHeaderView = searchController.searchBar
    
    
    candies = [Candy(category: "Chocolate", name: "Chocolate Bar"),
               Candy(category: "Chocolate", name: "Chocolate Chip"),
               Candy(category: "Chocolate", name: "Dark Chocolate"),
               Candy(category: "Hard", name: "Lollipop"),
               Candy(category: "Hard", name: "Candy Cane"),
               Candy(category: "Hard", name: "Jaw Breaker"),
               Candy(category: "Other", name: "Caramel"),
               Candy(category: "Other", name: "Sour Chew"),
               Candy(category: "Other", name: "Gummi Bear")
               ]
    
    if let splitViewController = splitViewController {
      let controllers = splitViewController.viewControllers
      detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? DetailViewController
    }
  }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        
        filteredCandies = candies.filter { candy in
            return candy.name.lowercaseString.containsString(searchText.lowercaseString)
        }
    }
    
  
    override func viewWillAppear(animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Table View
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return candies.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
    
    let candy = candies[indexPath.row]
    cell.textLabel!.text = candy.name
    cell.detailTextLabel!.text = candy.category
    return cell
  }
  
  // MARK: - Segues
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetail" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let candy = candies[indexPath.row]
        let detailController = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
        detailController.detailCandy = candy
        detailController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
        detailController.navigationItem.leftItemsSupplementBackButton = true
      }
    }
  }
  
}

