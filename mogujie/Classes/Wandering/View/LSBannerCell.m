/**
 *
 * ......................我佛慈悲.......................
 *                       _oo0oo_
 *                      o8888888o
 *                      88" . "88
 *                      (| -_- |)
 *                      0\  =  /0
 *                    ___/`---'\___
 *                  .' \\|     |// '.
 *                 / \\|||  :  |||// \
 *                / _||||| -卍-|||||- \
 *               |   | \\\  -  /// |   |
 *               | \_|  ''\---/''  |_/ |
 *               \  .-\__  '-'  ___/-. /
 *             ___'. .'  /--.--\  `. .'___
 *          ."" '<  `.___\_<|>_/___.' >' "".
 *         | | :  `- \`.;`\ _ /`;.`/ - ` : | |
 *         \  \ `_.   \_ __\ /__ _/   .-` /  /
 *     =====`-.____`.___ \_____/___.-`___.-'=====
 *                       `=---='
 *
 *..................佛祖开光 ,永无BUG....................
 *         CSDN博客:http://blog.csdn.net/song5347
 *       github地址:https://github.com/lingsuiderongyan
 *             邮箱:lingsuiderongyan@163.com
 */

#import "LSBannerCell.h"
#import <UIImageView+WebCache.h>
#import "LSModel.h"

@interface LSBannerCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation LSBannerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(LSModel *)model
{
    _model = model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.imageName] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.imageView.image = image;
    }];
    
}

@end
