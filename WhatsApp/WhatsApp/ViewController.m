//
//  ViewController.m
//  WhatsApp
//
//  Created by Adenike Olatunji on 13/06/2015.
//  Copyright (c) 2015 Adenike Olatunji. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSMutableArray *listInfo;
@property (nonatomic) NSInteger  messageHeight, xPosition, yPosition,  yPositiontimeLabel;
@property (nonatomic) NSString *messageTime, *messageDate;
@property (nonatomic) NSDate *now;
@property (nonatomic) NSDateFormatter *formatter;
@property (nonatomic) int messageCount;
@property(nonatomic)UINavigationBar *navBar;
@end

@implementation ViewController

{
    UILabel *label;
    UIToolbar *toolbar;
    UITableView *tableView;
    UILabel *messageLabel;
    CGRect  frame;
    NSArray *replyInfo;
    int messageInt;
}

#define TRIM(string) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]
- (void)viewDidLoad {
    [super viewDidLoad];
    // initialise variable
    _messageHeight =40;
    _xPosition = 80;
    _yPosition =70;
    _messageCount =0;
    _yPositiontimeLabel=0;
    messageInt =0;
    
    //create  message view
    _messageView = [[UIView alloc]init];
    _messageView.frame = CGRectMake(0, 10, 320, 420);
    
    _messageView.layer.borderColor =[UIColor colorWithRed:200.0f/100.0f green:220.0f/155.0f blue:120.0f/130.0f alpha:1.0f].CGColor;
    _messageView.layer.backgroundColor =[UIColor colorWithRed:200.0f/100.0f green:220.0f/155.0f blue:120.0f/130.0f alpha:1.0f].CGColor;
    
    [_messageView clipsToBounds];
    
    [self.view addSubview:_messageView];
    
    
    _listInfo = [[NSMutableArray alloc] init];
    
    
    replyInfo = [[NSArray alloc]init];
    
    replyInfo = @[@"Hi....",
                  @"Uh uh uh.........",
                  @"Wonderful day !!! Let's go swimming  ",
                  @"Awesome! ",
                  @"Hello.....",
                  @"Alright",
                  @"Ok ",];
    
    [self messageToolBar];
    [self  doNavigatorBar];
    [self  activityUpdate];
    [self getDate];
    [self messageReceived];
    
}


-(void)messageToolBar{
    
    //create toolbar using new
    toolbar = [UIToolbar new];
    toolbar.barStyle = UIBarStyleDefault;
    [toolbar sizeToFit];
    toolbar.frame = CGRectMake(0, 400, 320, 80);
    
    //Add buttons
    UIBarButtonItem *barbuttonItem1 = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                       target:self
                                       action:nil];
    
    UIBarButtonItem *barbuttonItem2 = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                       target:self
                                       action:nil];
    
    UIBarButtonItem *barbuttonItem4 = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemReply
                                       target:self
                                       action:@selector(sendMessage:)];
    
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                               target:nil
                                                                               action:nil];
    
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0,0,200,20)];
    _textField.layer.borderWidth=0.5f;
    _textField.layer.borderColor=[UIColor grayColor].CGColor;
    _textField.layer.cornerRadius = 5;
    _textField.delegate = self;
    UIBarButtonItem *textFieldItem = [[UIBarButtonItem alloc] initWithCustomView:_textField];
    
    NSArray *items = [NSArray arrayWithObjects: barbuttonItem1, spaceItem, textFieldItem,spaceItem, barbuttonItem2, spaceItem, barbuttonItem4, nil];
    
    //add array of buttons to toolbar
    [toolbar setItems:items animated:NO];
    
    [self.view addSubview:toolbar];
    
    
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [[self view] endEditing:TRUE];
    
}
-(void)doNavigatorBar{
    //create Navigation Bar
    _navBar = [[UINavigationBar alloc] init];
    _navBar.frame = CGRectMake(0, 0, 320, 60);
    
    UINavigationItem *navItem = [[UINavigationItem alloc]init ];
    
    navItem.title = @"Teri Hoop";
    
    //   UIImage *navBackgroundImage = [UIImage imageNamed:@"icon-back"];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:nil action:nil];
    
    UIBarButtonItem *icon =[[UIBarButtonItem alloc]initWithTitle:@"< Chats" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    navItem.rightBarButtonItem =backButton;
    navItem.leftBarButtonItem = icon;
    
    _navBar.items = @[navItem];
    
    [self.view addSubview:_navBar];
    
    
}



-(void) sendMessage: (id)sender {
    [_textField resignFirstResponder];
    [_listInfo addObject:_textField.text];
    
    [self numberofMessage:tableView];
    [self messageTableView:tableView viewForRowAtIndex:_messageCount];
    
    // to clear textfield
    _textField.text = @"";
    
    _messageCount++;
    [tableView reloadData];
}


- (NSInteger)numberofMessage:(UITableView *)messageTableView{
    
    return [_listInfo count];
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_listInfo count];
}

- (UILabel*)messageTableView:(UITableView *)messageView viewForRowAtIndex:(int)index{
    
    CGRect  messageRect = CGRectMake(_xPosition , _yPosition, 230, _messageHeight);
    messageLabel     = [[UILabel alloc] initWithFrame:messageRect];
    [messageLabel  setContentMode:UIViewContentModeCenter];
    messageLabel.clipsToBounds = YES;
    messageLabel.layer.cornerRadius = 4;
    messageLabel.layer.borderWidth = 1.0f;
    messageLabel.layer.borderColor =[UIColor colorWithRed:110.0f/140.0f green:220.0f/155.0f blue:120.0f/255.0f alpha:1.0f].CGColor;
    messageLabel.layer.backgroundColor =[UIColor colorWithRed:110.0f/140.0f green:220.0f/155.0f blue:120.0f/255.0f alpha:1.0f].CGColor;
    
    messageLabel.numberOfLines =0;
    
    messageLabel.text = [_listInfo[index] stringByAppendingString:@"          "] ;
    
    
    [messageLabel sizeToFit];
    messageLabel.adjustsFontSizeToFitWidth = YES;
    
    frame =messageLabel.bounds;
    
    if (![TRIM(messageLabel.text) isEqual:@""] ){
        [self.messageView addSubview:messageLabel];
        [self  getTimeLabel];
        _yPosition = _yPosition+ frame.size.height+ 10;
        _messageHeight =30;
        
        messageInt = messageInt+1;
        
        if (messageInt >1){
            [self messageReceived];
        }
    }
    return messageLabel;
    
}



-(void)getDate{
    
    _formatter = [[NSDateFormatter alloc] init];
    _formatter.dateFormat=@"MMM";
    NSString * monthString = [[_formatter stringFromDate:[NSDate date]] capitalizedString];
    _formatter.dateFormat=@"EEE";
    NSString * dayString = [[_formatter stringFromDate:[NSDate date]] capitalizedString];
    _formatter.dateFormat=@"dd";
    int day = [[_formatter stringFromDate:[NSDate date]]intValue] ;
    
    _messageDate = [dayString stringByAppendingFormat:@" %d %@",day, monthString];
    
    UILabel *dateLabel = [[UILabel alloc] init];
    dateLabel.frame = CGRectMake(200,65, 70, 20);
    dateLabel.layer.cornerRadius =10;
    dateLabel.layer.backgroundColor =[UIColor colorWithRed:110.0f/140.0f green:110.0f/105.0f blue:200.0f/205.0f alpha:1.0f].CGColor;
    
    dateLabel.text =_messageDate;
    dateLabel.adjustsFontSizeToFitWidth =YES;
    [self.view addSubview:dateLabel];
    
    
    
}


// update information

-(void)activityUpdate{
    _formatter = [[NSDateFormatter alloc] init];
    UILabel *lastTimeLabel = [[UILabel alloc] init];
    lastTimeLabel.frame = CGRectMake(50,42,50, 20);
    lastTimeLabel.layer.cornerRadius =10;
    NSDate *lastTime = [[NSDate date] dateByAddingTimeInterval:-(60 * 60)];
    _formatter.dateFormat=@"HH:mm";
    lastTimeLabel.text = [@"last seen today at  " stringByAppendingString: [_formatter stringFromDate: lastTime]];
    lastTimeLabel.textColor =[UIColor lightGrayColor];
    
    
    [lastTimeLabel sizeToFit ];
    [self.view addSubview:lastTimeLabel];
}



// Create auto reply
-(void) messageReceived{
    int  xposition =10;
    CGRect  replyRect = CGRectMake( xposition, _yPosition, 150, _messageHeight-20);
    UILabel  *replyLabel     = [[UILabel alloc] initWithFrame:replyRect];
    [replyLabel  setContentMode:UIViewContentModeCenter];
    replyLabel.clipsToBounds = YES;
    replyLabel.layer.cornerRadius = 4;
    replyLabel.layer.borderWidth = 1.0f;
    replyLabel.layer.borderColor =[UIColor colorWithRed:250.0f/150.0f green:250.0f/155.0f blue:120.0f/100.0f alpha:1.0f].CGColor;
    replyLabel.layer.backgroundColor =[UIColor colorWithRed:250.0f/150.0f green:250.0f/105.0f blue:120.0f/100.0f alpha:1.0f].CGColor;
    int idx =rand()%[replyInfo count];
    
    NSString *replySpace = @"         ";
    
    
    replyLabel.text = [replyInfo[idx] stringByAppendingString:replySpace];
    
    replyLabel.numberOfLines =0;
    
    [replyLabel sizeToFit];
    replyLabel.adjustsFontSizeToFitWidth = YES;
    
    
    
    [self.messageView addSubview:replyLabel];
    frame =replyLabel.bounds;
    
    
    // get time label
    CGRect  timeRect = CGRectMake(frame.size.width+ xposition -20, _yPosition-7, 20,_messageHeight);
    UILabel  *timeLabel = [[UILabel alloc] initWithFrame:timeRect];
    
    _formatter.dateFormat= @"HH:mm";
    timeLabel.text = [_formatter stringFromDate:[NSDate date]];
    timeLabel.textColor = [UIColor grayColor];
    timeLabel.adjustsFontSizeToFitWidth = YES;
    timeLabel.clipsToBounds =YES;
    timeLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.messageView addSubview:timeLabel];
    _yPosition = _yPosition+ frame.size.height+ 10;
    _messageHeight =30;
    
    
    
    
}


// create message time
-(void) getTimeLabel{
    
    CGRect  timeRect = CGRectMake(frame.size.width+_xPosition -20, _yPosition-7, 20,_messageHeight);
    UILabel  *timeLabel = [[UILabel alloc] initWithFrame:timeRect];
    
    _formatter.dateFormat= @"HH:mm";
    timeLabel.text = [_formatter stringFromDate:[NSDate date]];
    timeLabel.textColor = [UIColor grayColor];
    timeLabel.adjustsFontSizeToFitWidth = YES;
    timeLabel.clipsToBounds =YES;
    timeLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.messageView addSubview:timeLabel];
    
}

@end
