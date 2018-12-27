# CollectionViewShopCart
![你的小可爱已上线](http://upload-images.jianshu.io/upload_images/7882691-886183f3a8e30c93.GIF?imageMogr2/auto-orient/strip)
>淘宝点击商品可以进行商品的选择比如大小之类的，这类可以选择用collectionView来写，下面我讲述一下我的项目中所用的界面做一个简单的分析和实现想法，如果有更好的想法可以分享给我。

![效果.gif](https://upload-images.jianshu.io/upload_images/7882691-1a3726e9a59cf794.gif?imageMogr2/auto-orient/strip)

规格上面的是一个固定的`view`，规格下面第一个粉框框是`collectionView`，根据文字大小实现动态显示，数量一个框是`UICollectionReusableView`可以设为`footer`
>先来分析下如何是实现动态获取`string`长度
```
//collectionItemSize
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.getWidthWithText(text: self.dataArr[indexPath.row] as NSString, height: 30*W, font: 12*W)+20*W, height: 30*W)
    }
 //获取长度
    func getWidthWithText(text:NSString,height:CGFloat,font:CGFloat) -> CGFloat{
        let size = text.boundingRect(with: CGSize.init(width: CGFloat(MAXFLOAT), height: height), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: font) ], context: nil)
        return size.width
    }
    
```
进行`collectionItemSize`宽度赋值，如果是网络数据我们可以进行再`model`其中加一个属性为`width`把这个获取到`string`宽度进行封存，在`cell`内赋值时候要对这个`label`的宽度重新赋值，实现动态显示宽度。
>再来分析下如何实现单选问题，这个问题就很好解决创建一个全局变量cell，当每次点击时候进行一次赋值和样式改变就好了，我还是附上代码
```
 func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as!XBSetAddGoodsCollectionViewCell
        if (self.selectCell != cell) {
            cell.titleLable.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.5921568627, blue: 0.3254901961, alpha: 1)
            cell.titleLable.textColor = UIColor.white
            if self.selectCell != nil {
                selectCell.titleLable.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
                selectCell.titleLable.textColor = LabelColor_51
            }
            selectCell = cell
        }else{
            cell.titleLable.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.5921568627, blue: 0.3254901961, alpha: 1)
            cell.titleLable.textColor = UIColor.white
            selectCell = cell
        }
    }
```
>那么有人肯定问了，你的cell为何可以居左面，这个问题嘛 网上很多解决办法 毕竟都是大佬写好的我也不想自己写，毕竟我不是大佬，只是一个搬砖的，我就拿来搬了这样我把方法也分给大家吧！到底是哪个大佬我也忘了，光顾复制了，哈哈哈哈哈！

######1.首先你创建一个继承UICollectionViewFlowLayout的类
```
/// 对齐方向的枚举, 可拓展, 命名可根据自己喜好
enum AlignType : NSInteger {
    case left = 0
    case center = 1
    case right = 2
}

class CollectionViewAlignFlowLayout: UICollectionViewFlowLayout {
    //两个Cell之间的距离
    var betweenOfCell : CGFloat{
        didSet{
            self.minimumInteritemSpacing = betweenOfCell
        }
    }
    //cell对齐方式
    var cellType : AlignType = AlignType.center
    //在居中对齐的时候需要知道这行所有cell的宽度总和
    var sumCellWidth : CGFloat = 0.0
    
    override init() {
        betweenOfCell = 5.0
        super.init()
        scrollDirection = UICollectionViewScrollDirection.vertical
        minimumLineSpacing = 5
        sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
    }
    convenience init(_ cellType:AlignType){
        self.init()
        self.cellType = cellType
    }
    convenience init(_ cellType: AlignType, _ betweenOfCell: CGFloat){
        self.init()
        self.cellType = cellType
        self.betweenOfCell = betweenOfCell
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let layoutAttributes_super : [UICollectionViewLayoutAttributes] = super.layoutAttributesForElements(in: rect) ?? [UICollectionViewLayoutAttributes]()
        let layoutAttributes:[UICollectionViewLayoutAttributes] = NSArray(array: layoutAttributes_super, copyItems:true)as! [UICollectionViewLayoutAttributes]
        var layoutAttributes_t : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
        for index in 0..<layoutAttributes.count{
            
            let currentAttr = layoutAttributes[index]
            let previousAttr = index == 0 ? nil : layoutAttributes[index-1]
            let nextAttr = index + 1 == layoutAttributes.count ?
                nil : layoutAttributes[index+1]
            
            layoutAttributes_t.append(currentAttr)
            sumCellWidth += currentAttr.frame.size.width
            
            let previousY :CGFloat = previousAttr == nil ? 0 : previousAttr!.frame.maxY
            let currentY :CGFloat = currentAttr.frame.maxY
            let nextY:CGFloat = nextAttr == nil ? 0 : nextAttr!.frame.maxY
            
            if currentY != previousY && currentY != nextY{
                if currentAttr.representedElementKind == UICollectionElementKindSectionHeader{
                    layoutAttributes_t.removeAll()
                    sumCellWidth = 0.0
                }else if currentAttr.representedElementKind == UICollectionElementKindSectionFooter{
                    layoutAttributes_t.removeAll()
                    sumCellWidth = 0.0
                }else{
                    self.setCellFrame(with: layoutAttributes_t)
                    layoutAttributes_t.removeAll()
                    sumCellWidth = 0.0
                }
            }else if currentY != nextY{
                self.setCellFrame(with: layoutAttributes_t)
                layoutAttributes_t.removeAll()
                sumCellWidth = 0.0
            }
        }
        return layoutAttributes
    }
    
    /// 调整Cell的Frame
    ///
    /// - Parameter layoutAttributes: layoutAttribute 数组
    func setCellFrame(with layoutAttributes : [UICollectionViewLayoutAttributes]){
        var nowWidth : CGFloat = 0.0
        switch cellType {
        case AlignType.left:
            nowWidth = self.sectionInset.left
            for attributes in layoutAttributes{
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth
                attributes.frame = nowFrame
                nowWidth += nowFrame.size.width + self.betweenOfCell
            }
            break;
        case AlignType.center:
            nowWidth = (self.collectionView!.frame.size.width - sumCellWidth - (CGFloat(layoutAttributes.count - 1) * betweenOfCell)) / 2
            for attributes in layoutAttributes{
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth
                attributes.frame = nowFrame
                nowWidth += nowFrame.size.width + self.betweenOfCell
            }
            break;
        case AlignType.right:
            nowWidth = self.collectionView!.frame.size.width - self.sectionInset.right
            for var index in 0 ..< layoutAttributes.count{
                index = layoutAttributes.count - 1 - index
                let attributes = layoutAttributes[index]
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth - nowFrame.size.width
                attributes.frame = nowFrame
                nowWidth = nowWidth - nowFrame.size.width - betweenOfCell
            }
            break;
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
```
######2.声明一个全局变量`    var flowlayout: CollectionViewAlignFlowLayout!`并且实现代理就好，完事！
```
        flowlayout = CollectionViewAlignFlowLayout(AlignType.left, 10*W)
        flowlayout.minimumLineSpacing = 10*W
        flowlayout.minimumInteritemSpacing = 15*W
        flowlayout.sectionInset = UIEdgeInsets.init(top: 10*W, left: 10*W, bottom: 10*W, right: 10*W)
        
        let collectionView = UICollectionView(frame: CGRect(x:0, y: 0, width:0, height:0), collectionViewLayout: flowlayout)
```
>我的git demo地址：https://github.com/sunrose11/CollectionViewShopCart
下面的加减号 我是用的别人的 还是那句话自己写的有bug，这个哥们的写的很好而且很多样子，就一个类的代码量 我很是喜欢。给大家他的git：https://github.com/jkpang


 
