import UIKit

class AddEditEmojiTableViewController: UITableViewController {
    
    // MARK: - Instances
    var emoji: Emoji?

    // MARK: - Outlets
    @IBOutlet var symbolTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var usageTextField: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let emoji = emoji {
            symbolTextField.text = emoji.symbol
            nameTextField.text = emoji.name
            descriptionTextField.text = emoji.description
            usageTextField.text = emoji.usage
            title = "Edit Emoji"
        } else {
            title = "Add Emoji"
        }
        updateSaveButtonState()
    }
    
    // MARK: - Initializations
    init?(coder: NSCoder, emoji: Emoji?) {
        self.emoji = emoji
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func updateSaveButtonState() {
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        let usageText = usageTextField.text ?? ""
        saveButton.isEnabled = containsSingleEmoji(symbolTextField) && !nameText.isEmpty && !descriptionText.isEmpty && !usageText.isEmpty
    }
    
    func containsSingleEmoji(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text.count == 1 else {
            return false
        }
        let isEmoji = text.unicodeScalars.first?.properties.isEmojiPresentation ?? false
        return isEmoji
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveUnwind" else { return }

        let symbol = symbolTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        let usage = usageTextField.text ?? ""
        emoji = Emoji(symbol: symbol, name: name, description: description, usage: usage)
    }
    
    // MARK: - Actions
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
}
