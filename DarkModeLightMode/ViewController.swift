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
  
    var viewModel: ViewModel
    init(_ viewModel: ViewModel = ViewModel()){
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
    
    private lazy var darkModeView = ModeView(frame: .zero,
                                             mode: viewModel.darkMode,
                                             image: viewModel.darkImage,
                                             value: viewModel.modeValue,
                                             delegate: self)
    private lazy var lightModeView = ModeView(frame: .zero,
                                              mode: viewModel.lightMode,
                                              image: viewModel.lightImage,
                                              value: viewModel.modeValue,
                                              delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        configure()
        
        self.viewModel.darkModeReloadView = self.darkModeView.updateUI(_:)
        self.viewModel.lightModeReloadView = self.lightModeView.updateUI(_:)
    }
   
    
}

extension ViewController: ModeChaneDelegate{
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

