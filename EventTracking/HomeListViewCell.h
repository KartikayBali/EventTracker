//
//  HomeListViewCell.h
//  EventTracking
//
//  Created by Bali on 22/11/14.
//  Copyright (c) 2014 Keepworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeListViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *eventImageView;
@property (strong, nonatomic) IBOutlet UILabel *placeLabel;
@property (strong, nonatomic) IBOutlet UILabel *entryTypeLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageViewWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nameLabelWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *placeLabelWidth;


@end
