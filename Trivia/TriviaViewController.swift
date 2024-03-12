import UIKit

class TriviaViewController: UIViewController {

    @IBOutlet weak var ButtonD: UIButton!
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var ButtonC: UIButton!
    @IBOutlet weak var ButtonB: UIButton!
    @IBOutlet weak var TextMedia: UITextView! // Updated IBOutlet to UITextView
    @IBOutlet weak var Genre: UILabel!
    @IBOutlet weak var ButtonA: UIButton!
    
    // Props
    var currentQuestionIndex = 0
    var correctAnswers = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        displayQuestion()
        // Connect answer buttons to the answerButtonTapped function
                ButtonA.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)
                ButtonB.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)
                ButtonC.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)
                ButtonD.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        let currentQuestion = questions[currentQuestionIndex]
        let selectedAnswerIndex = sender.tag // Assuming you set tag values for the buttons
        
        // Check if the selected answer index matches the index of the correct answer
        if selectedAnswerIndex == currentQuestion.correctAnswerIndex {
            correctAnswers += 1
        }
        
        // Move to the next question if available
        currentQuestionIndex += 1
        if currentQuestionIndex < questions.count {
            // Display the next question
            displayQuestion()
        } else {
            // Show game over screen if all questions are answered
            showGameOverScreen()
        }
    }


    func displayQuestion() {
        let currentQuestion = questions[currentQuestionIndex]
        
        // Update question text in TextMedia UITextView
        TextMedia.text = currentQuestion.text
        
        // Update question number label
        questionTextLabel.text = "Question \(currentQuestionIndex + 1)/\(questions.count)"
        
        // Update genre label
        Genre.text = currentQuestion.genre
        
        // Update answer buttons
        let answerButtons = [ButtonA, ButtonB, ButtonC, ButtonD]
        for (index, button) in answerButtons.enumerated() {
            button?.setTitle(currentQuestion.answers[index], for: .normal)
        }
    }

    func showGameOverScreen() {
        let alert = UIAlertController(title: "Game Over", message: "You got \(correctAnswers) out of \(questions.count) questions correct.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { _ in
            self.restartGame()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func restartGame() {
        currentQuestionIndex = 0
        correctAnswers = 0
        displayQuestion()
    }
    
    // Data model
    struct Question {
        let text: String
        let genre: String
        let answers: [String]
        let correctAnswerIndex: Int
    }

    // Sample questions
    let questions: [Question] = [
        Question(text: "What is the capital of France?", genre: "Geography", answers: ["London", "Paris", "Berlin", "Rome"], correctAnswerIndex: 1),
        Question(text: "Which planet is known as the Red Planet?", genre: "Astronomy", answers: ["Earth", "Mars", "Venus", "Jupiter"], correctAnswerIndex: 1),
        Question(text: "What is 2 + 2?", genre: "Math", answers: ["3", "4", "5", "6"], correctAnswerIndex: 1)
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set background color to blue
        view.backgroundColor = UIColor.blue
    }
}

