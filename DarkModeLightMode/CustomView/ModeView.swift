//
//  ModeView.swift
//  DarkModeLightMode
//
//  Created by 박형환 on 2022/09/21.
//

import Foundation
import UIKit
import SnapKit



/// 재사용 뷰
/// 1. 다크모드
/// 2. 라이트모드
class ModeView: UIView {
    
    private var mode: Mode = {
        let mode = Mode.none
        return mode
    }()
    
    private var modeValue: ModeValue?
    
    var modeChangeDelegate: ModeChaneDelegate?
    
    private lazy var stackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 30
        return stack
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        
        return view
    }()
    
    
    //다크모드 , 라이트모드 라벨
    private lazy var modeNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black | UIColor.white
        label.font = UIFont(name: "NanumGothicBold", size: 20)
        label.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.kern: 0.1])
        return label
    }()

    //셀렉트 버튼
    private lazy var selectButton: SelectButton = {
        let button = SelectButton()
        button.setImage(UIImage(named: "Ellipse 15"), for: .selected)
        button.addTarget(self, action: #selector(myButtonTapped), for: .touchUpInside )
       return button
    }()
    
    
    //Button Tapped 시 ViewController 에 클릭한 mode 값 전달
    @objc func myButtonTapped(_ sender: UIButton){
        self.modeChangeDelegate?.modeChange(self.mode)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
       
    }
    
    convenience init(frame: CGRect, mode: Mode, image: UIImage, value: ModeValue, delegate: ModeChaneDelegate) {
        self.init(frame: frame)
        self.mode = mode
        self.modeNameLabel.text = mode.rawValue
        self.imageView.image = image
        self.modeChangeDelegate = delegate
        self.modeValue = value
        modeSelected()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("fatalError required init? modeView")
    }
    
    //viewModel에서 받아온 Bool 타입으로 버튼 isSelected 변경
    func updateUI(_ flag: Bool) {
        self.selectButton.isSelected = flag
    }
    
    func updateImage(_ image: UIImage?){
        self.imageView.image = image
        
    }
    
    
}
private extension ModeView {
    
//    // MARK: - Dark Mode Support
//    private func updateImageForCurrentTraitCollection() {
//        if traitCollection.userInterfaceStyle == .dark {
//            imageView.image = originalImage?.invertedColors()
//        } else {
//            imageView.image = originalImage
//        }
//    }

   
    
    /// 초기 modeValue 값으로 mode(dark or light)별로 기본값 설정 함수
    private func modeSelected(){
        switch self.mode{
        case .light:
            self.selectButton.isSelected = (self.modeValue == .lightValue)
            break
        case .dark:
            self.selectButton.isSelected = (self.modeValue == .darkValue)
            break
        default:
            print("error")
            break
        }
    }
    
    private func configure() {
        
        self.addSubview(stackView)
        
        stackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        [imageView,modeNameLabel,selectButton].forEach{
            stackView.addArrangedSubview($0)
        }
       
        selectButton.snp.makeConstraints{
            $0.width.height.equalTo(30)
        }
    }
}


//    private lazy var wrapperView: UIView = {
//        let view = UIView()
//        return view
//    }()

//        wrapperView.snp.makeConstraints{
//            $0.width.height.equalTo(30)
//        }
//        wrapperView.addSubview(selectButton)
        
