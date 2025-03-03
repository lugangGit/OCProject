//
//  ColumnModel.h
//  OC-Project
//
//  Created by 梓源 on 2020/12/24.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ColumnModel : BaseModel

@property (nonatomic , assign) NSInteger              isdelete;
@property (nonatomic , assign) NSInteger              level;
@property (nonatomic , assign) NSInteger              columnLevel;
@property (nonatomic , assign) NSInteger              columnId;
@property (nonatomic , copy) NSString              * columnName;
@property (nonatomic , assign) NSInteger              topCount;
@property (nonatomic , copy) NSString              * phoneIcon;
@property (nonatomic , copy) NSString              * padIcon;
@property (nonatomic , assign) NSInteger              orderId;
@property (nonatomic , copy) NSString              * keyword;
@property (nonatomic , copy) NSString              * descriptions;
@property (nonatomic , copy) NSString              * linkUrl;
@property (nonatomic , assign) BOOL              isForbidden;
@property (nonatomic , copy) NSString              * casNames;
@property (nonatomic , assign) NSInteger              rssCount;
@property (nonatomic , assign) NSInteger              appFixed;
@property (nonatomic , assign) NSInteger              appShow;
@property (nonatomic , assign) NSInteger              synXCX;
@property (nonatomic , assign) NSInteger              isScreen;
@property (nonatomic , copy) NSString              * columnType;
@property (nonatomic , copy) NSString              * columnStyle;
@property (nonatomic , assign) NSInteger              showReadCount;
@property (nonatomic , assign) NSInteger              showPubTime;
@property (nonatomic , assign) NSInteger              showPraiseCount;
@property (nonatomic , assign) NSInteger              showDiscussCount;
@property (nonatomic , assign) NSInteger              showStyle;
@property (nonatomic , copy) NSString              * topPic;
@property (nonatomic , assign) NSInteger              showCard;
@property (nonatomic , copy) NSString              * cardUrl;
@property (nonatomic , assign) NSInteger              showColumnPad;
@property (nonatomic , assign) NSInteger              onlyShowPad;
@property (nonatomic , assign) NSInteger              ShowPadTags;
@property (nonatomic , assign) NSInteger              showReadCountPad;
@property (nonatomic , assign) NSInteger              showPubTimePad;
@property (nonatomic , assign) NSInteger              showPraiseCountPad;
@property (nonatomic , assign) NSInteger              showDiscussCountPad;
@property (nonatomic , assign) NSInteger              showStylePad;
@property (nonatomic , copy) NSString              * topPicPad;
@property (nonatomic , assign) NSInteger              showCardPad;
@property (nonatomic , copy) NSString              * cardUrlPad;
@property (nonatomic , assign) NSInteger              topCountPad;
@property (nonatomic , assign) NSInteger              showMoreTipPad;
@property (nonatomic , copy) NSString              * appTypePadID;
@property (nonatomic , copy) NSString              * appTypePad;
@property (nonatomic , copy) NSString              * timeAxisIconPad;
@property (nonatomic , copy) NSString              * timeAxisColorPad;
@property (nonatomic , copy) NSString              * iconPad;
@property (nonatomic , assign) NSInteger              isIncomPad;
@property (nonatomic , assign) NSInteger              hasExtField;
@property (nonatomic , assign) NSInteger              iconBigType;
@property (nonatomic , assign) NSInteger              aggId;
@property (nonatomic , assign) NSInteger              appNormal;
@property (nonatomic , assign) NSInteger              childCount;
@property (nonatomic , copy) NSString              * createTime;

@end

NS_ASSUME_NONNULL_END
