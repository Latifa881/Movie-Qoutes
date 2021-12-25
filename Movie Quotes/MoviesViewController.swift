//
//  ViewController.swift
//  Movie Quotes
//
//  Created by administrator on 25/12/2021.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var disneyMovies = [Movie]()
    var selectedMovies = [Movie]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        
        moviesCollectionView.allowsMultipleSelection = true
        
        fillDisneyMovies()
        
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(swipedCollectionView))
        gesture.direction = .left
        view.addGestureRecognizer(gesture)
        
        
    
    }
    @objc func swipedCollectionView(){
        performSegue(withIdentifier: "MovieSegue", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let destination = navigationController.topViewController as! QuotesViewController
        
        destination.selectedMovies = selectedMovies

       
    }
    
    func fillDisneyMovies(){
        
        disneyMovies.append(Movie(name: "Peter Pan", image: UIImage(named: "Peter Pan")!, quote: "All it takes is faith and trust"))
        disneyMovies.append(Movie(name: "The Lion King", image: UIImage(named: "The Lion King")!, quote: "Remember who you are"))
        disneyMovies.append(Movie(name: "Frozen", image: UIImage(named: "Frozen")!, quote: "Some people are worth melting for"))
        disneyMovies.append(Movie(name: "Lilo and Stitch", image: UIImage(named: "Lilo and Stitch")!, quote: "Ohana means family. Family means nobody gets left behind or forgotten"))
        disneyMovies.append(Movie(name: "The Little Mermaid", image: UIImage(named: "The Little Mermaid")!, quote: "You want something done, you’ve got to do it yourself"))
        disneyMovies.append(Movie(name: "Aladdin", image: UIImage(named: "Aladdin")!, quote: "Do not be fooled by its commonplace appearance. Like so many things, it is not what is outside, but what is inside that counts"))
        disneyMovies.append(Movie(name: "Toy Story", image: UIImage(named: "Toy Story")!, quote: "To infinity and beyond!"))
        disneyMovies.append(Movie(name: "Luca", image: UIImage(named: "Luca")!, quote: "Silenzio Bruno!"))
        disneyMovies.append(Movie(name: "Cruella", image: UIImage(named: "Cruella")!, quote: "I Feel Sad That You Think That Looks Good"))
        disneyMovies.append(Movie(name: "The Princess and the Frog", image: UIImage(named: "The Princess and the Frog")!, quote: "The only way to get what you want in this world is through hard work"))
        disneyMovies.append(Movie(name: "Beauty and the Beast", image: UIImage(named: "Beauty and the Beast")!, quote: "Can anybody be happy if they aren’t free?"))
        disneyMovies.append(Movie(name: " The Incredibles", image: UIImage(named: " The Incredibles")!, quote: "Your identity is your most valuable possession. Protect it"))
        
      
        
    }


}


extension MoviesViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return disneyMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        
        cell.movieLabe.text = disneyMovies[indexPath.row].name
        cell.movieImage.image = disneyMovies[indexPath.row].image
    
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        selectedMovies.append(disneyMovies[indexPath.row])
        
        for index in 0..<selectedMovies.count{
            
            print(selectedMovies[index].name)
            
        }

        print("You selected movie : \(disneyMovies[indexPath.row].name)")


    }
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        
    //    print(" didHighlightItemAt : \(disneyMovies[indexPath.row].name)")
          let cell = collectionView.cellForItem(at: indexPath)

          cell?.layer.borderColor = UIColor.purple.cgColor
          cell?.layer.borderWidth = 4
          cell?.layer.cornerRadius = 10
        
       
          
      }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("un select cell number \(disneyMovies[indexPath.row].name)")
       
        
        let cell = collectionView.cellForItem(at: indexPath)

        cell?.layer.borderColor = .none
        cell?.layer.borderWidth = 0
        cell?.layer.cornerRadius = 0
        
        for index in 0..<disneyMovies.count{
            
            if selectedMovies[index].name == disneyMovies[indexPath.row].name{
                
                selectedMovies.remove(at: index)
                break
            }
            
        }
        for index in 0..<selectedMovies.count{
            
            print(selectedMovies[index].name)
            
        }
        
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width / 3.0) - 30
        let height = width
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
}
