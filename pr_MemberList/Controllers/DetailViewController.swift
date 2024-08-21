//
//  DetailViewController.swift
//  pr_MemberList
//
//  Created by 김현목 on 8/12/24.
//

import UIKit
import PhotosUI

final class DetailViewController: UIViewController {
    
    
    var member : Member?
    
    private let detailView = DetailView()
    
    weak var delegate : memberDelegate?
    
    
    override func loadView() {
        self.view = detailView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatas()
        setupButtonAction()
        imageButtonAction()
    }
    
    func setupDatas() {
        detailView.member = member
    }
    
    func setupButtonAction() {
        detailView.updateButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    func imageButtonAction() {
        detailView.addImageTapGesture(target: self, action: #selector(imageViewTapped))
    }
    
    @objc func saveButtonTapped() {
        
        if member == nil {
            let name = detailView.memberNameTextField.text ?? ""
            let age = Int(detailView.memberAgeTextField.text ?? "")
            let phoneNumber = detailView.phoneTextField.text ?? ""
            let address = detailView.addressTextField.text ?? ""
            
            var newMember = Member(name: name, age: age, phone: phoneNumber, address: address)
            newMember.memberImage = detailView.mainImageView.image
            
            delegate?.addNewMember(newMember)
        } else {

            member?.name = detailView.memberNameTextField.text ?? ""
            member?.age = Int(detailView.memberAgeTextField.text ?? "")
            member?.phone = detailView.phoneTextField.text ?? ""
            member?.address = detailView.addressTextField.text ?? ""
            member?.memberImage = detailView.mainImageView.image
            
            detailView.member = member
            
            if let updatedMember = member {
                delegate?.updateMemberInfo(index: updatedMember.memberId, updatedMember)
            }
        }
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc func imageViewTapped() {
         // PHPickerViewController 설정
         var config = PHPickerConfiguration()
         config.filter = .images  // 이미지 선택만 가능하게 필터링
         config.selectionLimit = 1  // 한번에 하나의 이미지 선택 가능

         let picker = PHPickerViewController(configuration: config)
         picker.delegate = self
         
         present(picker, animated: true, completion: nil)  // 이미지 선택 화면 호출
     }

}

extension DetailViewController : PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)  // 피커 닫기
        
        guard let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) else {
            return
        }
        
        provider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
            guard let self = self, let selectedImage = image as? UIImage else {
                return
            }
            
            // 이미지 뷰에 선택된 이미지 설정 (메인 스레드에서 실행)
            DispatchQueue.main.async {
                self.detailView.mainImageView.image = selectedImage
            }
        }
    }
}
