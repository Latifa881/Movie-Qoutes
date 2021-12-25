//
//  QuotesViewController.swift
//  Movie Quotes
//
//  Created by administrator on 25/12/2021.
//

import UIKit
import RVS_AutofillTextField

class QuotesViewController: UIViewController   {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var movieTextField: RVS_AutofillTextField!
    
    @IBOutlet weak var scoreStackView: UIStackView!
    var selectedMovies:[Movie]?
    var testingTextDictionary = [String]()
    
    var movieAnswerName = ""
    var movieAnswerImage = UIImage(named: "Frozen")
    var score = 0
    var quote = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieTextField?.dataSource = self
    

        movieTextField.layer.borderColor =  UIColor.purple.cgColor
        movieTextField.layer.borderWidth = 2
        movieTextField.layer.cornerRadius = 7
        
        guard var selectedMovies = selectedMovies else {return}

        for movie in selectedMovies{
            testingTextDictionary.append(movie.name)
        }
        
        if selectedMovies.isEmpty{
            quoteLabel.text = "You Didn't Select Any Movie! Please Go Back and Select Some Movies."
        }
        
        setNewMovieQuote()
        
    }
  
    
    @IBAction func editingChanged(_ sender: Any) {
        print(movieTextField.text)
        
        if movieTextField.text?.count == movieAnswerName.count{
            checkAnswer()
        }
    }
    
    @IBAction func showMovieAnswer(_ sender: Any) {
        
        showAlertAction(title: "Help" , message: "Do You Want To See Correct Answer?")
     
    }
    @objc func tapFunction(sender:UITapGestureRecognizer) {

           showAlertAction(title: "Skip", message: "Do You Want To Skip This Quote?")
        }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setNewMovieQuote(){
        //  0 1
        guard var selectedMovie = selectedMovies else {return}
        
        selectedMovie.shuffle()
        
        if selectedMovie.isEmpty{
            
            
        }else{
            quoteLabel.text = selectedMovie[0].quote
            quote = selectedMovie[0].quote
            movieTextField.text = ""
            movieAnswerName = selectedMovie[0].name
            movieAnswerImage = selectedMovie[0].image
           
            typewriterAnimation(text: selectedMovie[0].quote, label: quoteLabel)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(QuotesViewController.tapFunction))
            quoteLabel.isUserInteractionEnabled = true
            quoteLabel.addGestureRecognizer(tap)
            
            
        
        }
    }
    
    func checkAnswer(){
        if movieAnswerName == movieTextField.text{
            
            score += 1
            movieImage.image = movieAnswerImage
            movieImage.isHidden = false
            movieTextField.isHidden = true
            quoteLabel.isHidden = true
            scoreStackView.isHidden = true
            //Delay
            delayAnswer()
            self.setNewMovieQuote()
        }
      
        
    }
    func delayAnswer(){
        let seconds = 3.0
                   DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                       // Put your code which should be executed with a delay here

                       self.movieImage.isHidden = true
                       self.movieTextField.isHidden = false
                       self.quoteLabel.isHidden = false
                       self.scoreStackView.isHidden = false
                       self.scoreLabel.text = "\(self.score)"
                    
               }
    }
    
    //This function is responsible of animating the text of type UILable only
    func typewriterAnimation(text:String, label:UILabel){
        label.text = ""
        for i in text {
            label.text! += "\(i)"
            RunLoop.current.run(until: Date()+0.12)
        }
    }
    func showAlertAction(title: String, message: String){
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "YES", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
                if title == "Help"{
                    self.movieTextField.isHidden = true
                    self.scoreStackView.isHidden = true
                    self.quoteLabel.text = "The Name Of Movie That Has This Quotes Is \n\(self.movieAnswerName)"
                    self.view.backgroundColor = .purple
                    let seconds = 3.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                      
                        self.movieTextField.isHidden = false
                        self.quoteLabel.text = self.quote
                        self.scoreStackView.isHidden = false
                        self.scoreLabel.text = "\(self.score)"
                        self.view.backgroundColor = .white
                        
                        
                    }
                }
                else {
                    self.setNewMovieQuote()
                }

            }))
            alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    
}

extension QuotesViewController : RVS_AutofillTextFieldDataSource {
    
    /* ################################################################## */
    /**
     This is an Array of structs, that are the searchable data collection for the text field.
     If this is empty, then no searches will return any results.
     */
    var textDictionary: [RVS_AutofillTextFieldDataSourceType] {
        testingTextDictionary.compactMap {
            let currentStr = $0.trimmingCharacters(in: .whitespacesAndNewlines)
            return !currentStr.isEmpty ? RVS_AutofillTextFieldDataSourceType(value: currentStr) : nil
        }
    }
    
    
}
