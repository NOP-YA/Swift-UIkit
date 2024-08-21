import UIKit
import PhotosUI

class DetailView: UIView {
    
    var member: Member? {
        didSet {
            guard var member = member else {
                updateButton.setTitle("SAVE", for: .normal)
                memberIdTextField.text = "\(Member.memberNumber)"
                return
            }
            
            mainImageView.image = member.memberImage
            memberIdTextField.text = "\(member.memberId)"
            memberNameTextField.text = member.name
            memberAgeTextField.text = "\(member.age ?? 0)"
            phoneTextField.text = member.phone
            addressTextField.text = member.address
        }
    }
    
    private var stackViewTopConstraint: NSLayoutConstraint!
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var imageContainView : UIView = {
        let imageContainView = UIView()
        imageContainView.addSubview(mainImageView)
        imageContainView.translatesAutoresizingMaskIntoConstraints = false
        return imageContainView
    }()
    
    let memberIdLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "멤버번호: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let memberIdTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var memberIdStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [memberIdLabel, memberIdTextField])
        stview.axis = .horizontal
        stview.distribution = .fill
        stview.alignment = .fill
        stview.spacing = 5
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    let memberNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "이        름:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let memberNameTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var memberNameStackView : UIStackView = {
        let stview = UIStackView(arrangedSubviews: [memberNameLabel, memberNameTextField])
        stview.axis = .horizontal
        stview.distribution = .fill
        stview.alignment = .fill
        stview.spacing = 5
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    let memberAgeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "나        이:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let memberAgeTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var memberAgeStackView : UIStackView = {
        let stview = UIStackView(arrangedSubviews: [memberAgeLabel, memberAgeTextField])
        stview.axis = .horizontal
        stview.distribution = .fill
        stview.alignment = .fill
        stview.spacing = 5
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "전화번호:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneTextField : UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var memberPhoneStackView : UIStackView = {
        let stview = UIStackView(arrangedSubviews: [phoneLabel, phoneTextField])
        stview.axis = .horizontal
        stview.distribution = .fill
        stview.alignment = .fill
        stview.spacing = 5
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "주       소:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressTextField : UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var memberAddressStackView : UIStackView = {
        let stview = UIStackView(arrangedSubviews: [addressLabel, addressTextField])
        stview.axis = .horizontal
        stview.distribution = .fill
        stview.alignment = .fill
        stview.spacing = 5
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    let updateButton : UIButton = {
        let button = UIButton()
        button.setTitle("UPDATE", for: .normal)
        button.backgroundColor = .systemBlue
        button.frame.size.height = 40
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var stackView : UIStackView = {
        let st = UIStackView(arrangedSubviews: [imageContainView, memberIdStackView, memberNameStackView, memberAgeStackView, memberPhoneStackView, memberAddressStackView, updateButton])
        st.axis = .vertical
        st.distribution = .fill
        st.alignment = .fill
        st.spacing = 10
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainImageView.layer.cornerRadius = mainImageView.frame.width / 2
    }
    
    func setupStackView() {
        self.addSubview(stackView)
    }
    
    func setupMemberIdTextField() {
        memberIdTextField.delegate = self
    }
    
    func addImageTapGesture(target: Any, action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        mainImageView.addGestureRecognizer(tapGesture)
    }
    
    func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(moveUpAction), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveDownAction), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            mainImageView.widthAnchor.constraint(equalToConstant: 150),
            mainImageView.heightAnchor.constraint(equalToConstant: 150),
            mainImageView.centerXAnchor.constraint(equalTo: imageContainView.centerXAnchor),
            mainImageView.centerYAnchor.constraint(equalTo: imageContainView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageContainView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        
        NSLayoutConstraint.activate([
            memberIdLabel.widthAnchor.constraint(equalToConstant: 70),
            memberNameLabel.widthAnchor.constraint(equalToConstant: 70),
            memberAgeLabel.widthAnchor.constraint(equalToConstant: 70),
            phoneLabel.widthAnchor.constraint(equalToConstant: 70),
            addressLabel.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        stackViewTopConstraint = stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10)
        
        NSLayoutConstraint.activate([
            stackViewTopConstraint,
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func moveUpAction() {
        stackViewTopConstraint.constant = -20
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    @objc func moveDownAction() {
        stackViewTopConstraint.constant = 10
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    
    
    // Custom initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupStackView()
        setConstraints()
        setupMemberIdTextField()
        setupNotification()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
           // NotificationCenter 옵저버 해제
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
       }
    
    
}

extension DetailView : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == memberIdTextField {
            return false
        }
        
        return true
    }
}
