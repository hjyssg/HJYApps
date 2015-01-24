//
//  TBITItemTableViewCell.m
//  BluetoothObjectFinder
//
//  Created by Junyang Huang on 6/9/14.


#import "TBITItemTableViewCell.h"


@implementation TBITItemTableViewCell


-(id)init
{
    self = [[[NSBundle mainBundle]loadNibNamed:@"TBITItemTableViewCell" owner:self options:nil] objectAtIndex:0];
    return self;
}


-(id)initWIthItem:(Item *)item
{
    self =[self init];
    [self updateUIWithItem:item];
    return self;
}

-(void)updateUIWithItem:(Item *)item
{
    [self.nameLabel setText:item.name];

    ItemPhoto *photo = [ItemPhoto MR_findFirstByAttribute:@"uuid" withValue:item.uuid];
    if (photo == NULL){
        photo = [ItemPhoto MR_findFirstByAttribute:@"uuid" withValue:item.uuid];
    }
    
    if (photo){
        UIImage *image = [UIImage imageWithData:photo.data];
        [self.photoView setImage:image];
    }
    
}


-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    for (UIView *view in self.subviews)
    {
        if ([view isKindOfClass:[UILabel class]])
        {
            UILabel *label = (UILabel *)view;
            label.adjustsFontSizeToFitWidth = YES;
        }
    }
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
