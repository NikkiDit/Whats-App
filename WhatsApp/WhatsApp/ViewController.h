//
//  ViewController.h
//  WhatsApp
//
//  Created by Adenike Olatunji on 13/06/2015.
//  Copyright (c) 2015 Adenike Olatunji. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate , UITableViewDataSource, UINavigationBarDelegate>

@property (nonatomic, strong) UIView *messageView;
@end

