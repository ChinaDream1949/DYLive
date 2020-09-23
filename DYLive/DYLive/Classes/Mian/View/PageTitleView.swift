//
//  PageTitleView.swift
//  DYLive
//
//  Created by MR.Sahw on 2020/9/23.
//

import UIKit

// 设置代理
protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView,selectedIndex index : Int)
}
// 设置常量
private let scrollViewLineH : CGFloat = 2
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85) // 元组
private let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)

class PageTitleView: UIView {

    // MARK: - 自定属性
    private var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
    private var titles : [String]
    private var titleLables : [UILabel] = [UILabel]() // 为了拿到lable
    // MARK: - 懒加载 scrollview
    private lazy var scrollView : UIScrollView = {
       let scrollview = UIScrollView()
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.scrollsToTop = false
        scrollview.bounces = false
        return scrollview
    }()
    // MARK: - 懒加载 scrollviewline
    private lazy var scrollLine : UIView = {
       let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    // MARK: - 自定义构造函数
    init(frame : CGRect,titles : [String]) {
        self.titles = titles;
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageTitleView {
    private func setupUI() {
        // 1.添加scrollview
        addSubview(scrollView)
        scrollView.frame = bounds
        // 2.添加title对应的lable
        setupTitlesLabels()
        // 3.设置底线和滚动滑块
        setupButtomMenuScrolline()
    }
    
    private func setupTitlesLabels() {
        // 0.确定label的一些frame的值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - scrollViewLineH
        let labelY : CGFloat = 0
        
        for (index, titls) in titles.enumerated() {
            // 1.创建label
            let lable = UILabel()
            
            // 2.设置lable属性
            lable.text = titls
            lable.tag = index
            lable.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            lable.font = UIFont.systemFont(ofSize: 16.0)
            lable.textAlignment = .center
            
            // 3.设置label 的 frame
            let labelX : CGFloat = labelW * CGFloat(index)
            
            
            lable.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 4.添加到scrollview
            scrollView.addSubview(lable)
            titleLables.append(lable) // 添加到lable数组
            // 5.lable添加手势
            lable.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLableTapClik(tapGes:)))
            lable.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupButtomMenuScrolline() {
        // 1.创建底线
        let buttomLine = UIView()
        buttomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5;
        buttomLine.frame = CGRect(x: 0, y: frame.height-lineH, width: frame.width, height: lineH)
        addSubview(buttomLine)
        // 2.添加scrollLine
        // 2.1获取第一个lable
        guard let firstLab = titleLables.first else { return }
        firstLab.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        // 2.2设置scrollLine属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLab.frame.origin.x, y: frame.height-scrollViewLineH, width: firstLab.frame.width, height: scrollViewLineH)
    }
}

// MARK: - 监听点击
extension PageTitleView {
    @objc private func titleLableTapClik(tapGes : UITapGestureRecognizer) {
        // 1.获取当前lab下标值
        guard let currentLable = tapGes.view as? UILabel else {return}
        // 2.获取之前lab
        let oldLab = titleLables[currentIndex]
        // 3.切换文字颜色
        currentLable.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLab.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        // 4.保存最新lab
        currentIndex = currentLable.tag
        // 5.滚动条
        let scrollLineX = CGFloat(currentLable.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        // 6.通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}
// MARK: - 对外暴露方法
extension PageTitleView {
    func setTitleWithProgress(progress : CGFloat,soureIndex : Int ,targetIndex : Int){
        // 1.取出sourelable、targetLable
        let sourceLab = titleLables[soureIndex]
        let targetLab = titleLables[targetIndex]
        
        // 2.处理滑块逻辑
        let moveTotalX = targetLab.frame.origin.x - sourceLab.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLab.frame.origin.x + moveX
        // 3.文字颜色渐变
        // 3.1 取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        // 3.2 变化sourceLab
        sourceLab.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        // 3.3 变化targetLab
        targetLab.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        // 4.记录最新index (防止isForbidScrollDelegate 滑动再点击颜色bug)
        currentIndex = targetIndex
    }
}
