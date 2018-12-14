# CollectionViewShopCart
实现淘宝一类选择商品自适应长度
淘宝点击商品可以进行商品的选择比如大小之类的，这类可以选择用的的CollectionView来写，下面我讲述一下我的项目中所用的界面做一个简单的分析和实现想法，如果有更好的想法可以分享给我。

规格上面的是一个固定的view，规格下面第一个粉框框是collectionView，根据文字大小实现动态显示，一个数量的英文框UICollectionReusableView可以设为footer
来先下分析如何的英文实现动态电子杂志string长度

//collectionItemSize
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.getWidthWithText(text: self.dataArr[indexPath.row] as NSString, height: 30*W, font: 12*W)+20*W, height: 30*W)
    }
 //获取长度
    func getWidthWithText(text:NSString,height:CGFloat,font:CGFloat) -> CGFloat{
        let size = text.boundingRect(with: CGSize.init(width: CGFloat(MAXFLOAT), height: height), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: font) ], context: nil)
        return size.width
    }
 
