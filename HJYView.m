//
//  HJYView.m
//  SubclassUIViewExample
//
//  Created by junyang_huang on 7/2/13.
//  Copyright (c) 2013 hjyssg.com. All rights reserved.
//

#import "HJYView.h"

@implementation HJYView


-(id)init
{
    //load xib from main bundle and assign it to self
    self = [[[NSBundle mainBundle]loadNibNamed:@"HJYView" owner:self options:nil] objectAtIndex:0];
    
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [self init];
    [self setFrame:frame];
    
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showOutput:) name:UITextFieldTextDidChangeNotification object:nil];
}

-(IBAction)showOutput:(id)sender
{
    self.outputLabel.text = self.inputTextField.text;
    
    //present random each time
    self.outputLabel.textColor = [UIColor colorWithRed:rand()*256/256.0 green:rand()*256/256.0 blue:rand()*256/256.0 alpha:1.0];
}

@end
