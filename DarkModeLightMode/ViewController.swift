//
//  ViewController.swift
//  DarkModeLightMode
//
//  Created by 박형환 on 2022/09/20.
//

import UIKit
import SnapKit

//셀렉트 버튼 어떤모드의 버튼을 클릭했는지에 대한 값을 가져오기 위한 프로토콜
protocol ModeChaneDelegate {
    func modeChange(_ mode: Mode)
}

class ViewController: UIViewController {
  
    var viewModel: DarkModeLightModeProtocol
    
    init(_ viewModel: DarkModeLightModeProtocol = ViewModel()){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // didSet -> viewModel의 ModeValue 변경
    private var modeValue: ModeValue = .lightValue {
        didSet{
            viewModel.modeValue = self.modeValue
        }
    }
    
    private lazy var titleLabel : UILabel = {
       let label = UILabel()
        label.settingTitleLabel()
        return label
    }()
    private lazy var redLabel: UILabel = {
        let label = UILabel()
        label.settingRedLabel()
        return label
    }()
    
    private lazy var okButton: OKButton = {
        let button = OKButton()
        return button
    }()
    
    private let imageModel = ImageModel()
    
    private lazy var imageSize = imageModel.imageSize
    
    private lazy var darkModeView = ModeView(frame: .zero,
                                             mode: .dark,
                                             image: imageModel.darkImage,
                                             value: viewModel.modeValue,
                                             delegate: self)
    private lazy var lightModeView = ModeView(frame: .zero,
                                              mode: .light,
                                              image: imageModel.lightImage,
                                              value: viewModel.modeValue,
                                              delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()

        self.viewModel.darkModeReloadView = self.darkModeView.updateUI(_:)
        self.viewModel.lightModeReloadView = self.lightModeView.updateUI(_:)
        self.viewModel.updateUserInterfaceStyle = self.setDisplayMode
        self.viewModel.updateImageForCurrentTraitCollection = self.setImageDisplayMode
    }
    
    
    /// mode에 따른 이미지 변경
    private func setImageDisplayMode(){
        
            if self.traitCollection.userInterfaceStyle == .dark {
                
                self.darkModeView.updateImage(self.imageModel.darkImage.invertedColors()?.resized(self.imageSize))
                self.lightModeView.updateImage(self.imageModel.lightImage.invertedColors()?.resized(self.imageSize))
            }else {
                
                self.darkModeView.updateImage(self.imageModel.darkImage)
                self.lightModeView.updateImage(self.imageModel.lightImage)
            }
        
    }
    
    private func setDisplayMode() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return
            }
            switch self.viewModel.modeValue {
            case .lightValue:
                self.modeChangeAnimation(.light)
            case .darkValue:
                self.modeChangeAnimation(.dark)
            }
        }
    }
    
    private func modeChangeAnimation(_ style: UIUserInterfaceStyle) {
        UIView.animate(withDuration: 0.5, animations: {
            self.overrideUserInterfaceStyle = style
               self.view.backgroundColor = .secondarySystemBackground
           }) { (_) in
               print("animation done")
           }
    }
    
    //ViewController 의 overrideUserInterfaceStyle 이 변경 되었을때 호출
    // -> updateImageForCurrent call (image convert 함수)
    internal override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        viewModel.updateImageForCurrentTraitCollection?()
    }
}

extension ViewController: ModeChaneDelegate{
    
    
    
    /// ModeView 에서 버튼 클릭을 했을때 이 함수 호출
    /// - Parameter mode: dark OR light
    ///  dark 버튼을 눌렀는지 OR light 버튼을 눌렀는지 판별후 -> vc의 modeValue 변경
    func modeChange(_ mode: Mode) {
        switch mode {
        case .dark:
            self.modeValue = .darkValue

        case .light:
            self.modeValue = .lightValue
            
        case .none:
            break
        }
    }
}


private extension ViewController{
    
    private func configure() {
        self.view.backgroundColor = .secondarySystemBackground
        [titleLabel,redLabel,darkModeView,lightModeView,okButton].forEach{
            self.view.addSubview($0)
        }
       
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
        }
        redLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        darkModeView.snp.makeConstraints{
            $0.top.equalTo(redLabel.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(44)
        }
        lightModeView.snp.makeConstraints{
            $0.top.equalTo(darkModeView.snp.top)
            $0.trailing.equalToSuperview().inset(44)
        }
        okButton.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }
    }
}
//NanumGothicBold
//NanumGothicBold
//NanumGothicExtraBold

