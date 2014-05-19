//
//  CellView.h
//  PSCollectionViewDemo
//
//  Created by Eric on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PSCollectionViewCell.h"

@interface RootPscollectionCell : PSCollectionViewCell
@property(nonatomic,strong)IBOutlet UIView *viewtop;
@property (strong, nonatomic) IBOutlet UIImageView *picView;
@property (strong, nonatomic) IBOutlet UIImageView *picViewAudience;
@property(nonatomic,strong)IBOutlet UIView *view1;
@property(nonatomic,strong)IBOutlet UILabel *labelaudicecount;
@property(nonatomic,strong)IBOutlet UILabel *labenickname;
@property(nonatomic,strong)IBOutlet UIView *viewbgofname;
@property(nonatomic,strong)IBOutlet UILabel *labelmotto;
@property(nonatomic,strong)IBOutlet UILabel *labelonlinenum;
@end
