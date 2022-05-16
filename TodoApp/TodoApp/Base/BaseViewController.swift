//
//  BaseViewController.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 15/05/2022.
//

import UIKit
import NVActivityIndicatorView
import SnapKit
import SVProgressHUD

protocol DecorationChangable: AnyObject {
    func setupColors()
    func setupLocalize()
}

public enum LeftBarItem {
    case none, back, close, title(String, UIColor?)
}

open class BaseViewController: UIViewController, DecorationChangable, UIGestureRecognizerDelegate {
    
    private lazy var activityIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.backgroundColor = .gray
        indicator.color = .white
        indicator.style = .large
        return indicator
    }()
    
    open var leftBarItemOption: LeftBarItem { .back }
    
    open lazy var lbTitle:UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        lb.textAlignment = .center
        lb.numberOfLines = 1
        lb.sizeToFit()
        lb.minimumScaleFactor = 0.8
        lb.adjustsFontSizeToFitWidth = true
        lb.textColor = .black
        return lb
    }()
    
    open lazy var btnTitle:UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
        btn.titleLabel?.textAlignment = .center
        return btn
    }()
    
    open lazy var btnBackButton: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        btn.contentHorizontalAlignment = .left
        btn.tintColor = .black
        
        switch leftBarItemOption {
        case .back:
            btn.setImage(UIImage(systemName: "arrowshape.turn.up.left.fill"), for: .normal)
        case .close:
            break
        case .none:
            btn.isHidden = true
        case .title(let title, let color):
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(color ?? .blue, for: .normal)
        }
        
        btn.imageView?.contentMode = .scaleAspectFit
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(handleLeftAction), for: .touchUpInside)
        return btn
        
    }()
    
    open lazy var btnRight: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(handleRightAction), for: .touchUpInside)
        return btn
    }()
    
    open var nvActivityIndicator: NVActivityIndicatorView?
    open var refreshControlNV: UIRefreshControl?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setupColors()
        setupLocalize()
        setupBackButton()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        debugPrint("🚀 \(self) deinit")
    }
    
    open var hiddenNavigationBar: Bool { true }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        if self.hiddenNavigationBar {
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    @objc
    private func didChangeLocalization() {
        setupLocalize()
    }
    
    open func addPullToRefreshNV(to view: UIView) {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .clear
        refreshControl.addTarget(self, action: #selector(handlePullRefreshNV(_:)), for: .valueChanged)
        view.addSubview(refreshControl)
        
        nvActivityIndicator = NVActivityIndicatorView(frame: refreshControl.bounds, type: .ballSpinFadeLoader, color: .lightGray, padding: 15)
        nvActivityIndicator?.backgroundColor = refreshControl.backgroundColor
        refreshControl.addSubview(nvActivityIndicator!)
        nvActivityIndicator!.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
        })
        
        refreshControl.tintColor = refreshControl.backgroundColor
        refreshControlNV = refreshControl
    }
    
    @objc open func handlePullRefreshNV(_ refresh: UIRefreshControl) {
        self.nvActivityIndicator?.startAnimating()
        DispatchQueue.main.async {
            refresh.beginRefreshing()
        }
    }
    
    open func endRefreshNV() {
        self.nvActivityIndicator?.stopAnimating()
        DispatchQueue.main.async {
            self.refreshControlNV?.endRefreshing()
        }
    }
    
    open func setupColors() {
        // preconditionFailure("This method must be overridden \(self)")
    }
    
    open func setupLocalize() {
        // preconditionFailure("This method must be overridden \(self)")
    }
    
    // MARK: - Private functions
    open func setUpUI() {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            appearance.shadowColor = .clear
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        } else {
            navigationBar.shadowImage = UIImage()
            navigationBar.barStyle = .default
            navigationBar.barTintColor = .white
        }
        
        navigationBar.isTranslucent = false
    }
    
    open func setupBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.btnBackButton)
        
        if self.navigationItem.rightBarButtonItem == nil {
            let btn = UIButton()
            btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        }
    }
    
    // MARK: - Public functions
    open func setTitle(title: String, textColor: UIColor, titleFont: UIFont) {
        lbTitle.font = titleFont
        lbTitle.text = title.uppercased()
        lbTitle.textColor = textColor
        let titleView = UIView()
        titleView.addSubview(lbTitle)
        lbTitle.fillSuperview()
        self.navigationItem.titleView = titleView
    }
    
    open func setBtnTitle(title: String, color: UIColor, titleFont: UIFont, icDown: UIImage, icUp: UIImage) {
        btnTitle.setTitleColor(color, for: .normal)
        btnTitle.setTitle(title, for: .normal)
        btnTitle.titleLabel?.font = titleFont
        
        btnTitle.setImage(icDown, for: .normal)
        btnTitle.setImage(icUp, for: .selected)
        btnTitle.imageView?.tintColor = color
        
        btnTitle.addTarget(self, action: #selector(handleTitleAction), for: .touchUpInside)
        btnTitle.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:15)
        btnTitle.semanticContentAttribute = .forceRightToLeft
        
        self.navigationItem.titleView = btnTitle
        
    }
    
    open func setupRightButton(image: UIImage? = nil,
                               buttonTitle: String? = nil,
                               textColor: UIColor,
                               buttonColor: UIColor,
                               titleFont: UIFont) {
        let wrapperWidth = 70.0
        let wrapperHeight = 44.0
        let btnHeight = 22.0
        
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: wrapperWidth, height: wrapperHeight))
        customView.backgroundColor = .clear
        
        if let unwrap = image {
            btnRight.setImage(unwrap.templateImage(), for: .normal)
            btnRight.imageView?.contentMode = .scaleAspectFit
        }
        
        btnRight.tintColor = buttonColor
        btnRight.semanticContentAttribute = .forceRightToLeft
        btnRight.contentHorizontalAlignment = .right
        btnRight.setTitle(buttonTitle, for: .normal)
        btnRight.setTitleColor(textColor, for: .normal)
        btnRight.titleLabel?.font = titleFont
        
        btnRight.titleEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
        btnRight.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        customView.addSubview(btnRight)
        
        btnRight.frame = CGRect(x:0,
                                y: (wrapperHeight - btnHeight)/2.0,
                                width: wrapperWidth,
                                height: btnHeight)
        
        btnRight.addTarget(self, action: #selector(handleRightAction), for: .touchUpInside)
        navigationItem.setRightBarButton(UIBarButtonItem(customView: customView), animated: true)
    }
    
    @objc open func handleLeftAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc open func handleTitleAction( _ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
    }
    @objc open func dismissDropdownlist() {
        btnTitle.isSelected = !btnTitle.isSelected
        
    }
    @objc open func handleRightAction(_ sender: UIButton ) {
        sender.isSelected = !sender.isSelected
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: Loading indicator
public extension BaseViewController {
    func dismissLoadingIndicator() {
        SVProgressHUD.dismiss()
    }
    
    func showLoadingIndicator() {
        SVProgressHUD.show()
    }
}
