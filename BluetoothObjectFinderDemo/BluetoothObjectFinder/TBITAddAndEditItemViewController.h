//
//  TBITAddItemViewController.h
//  BluetoothObjectFinder
//
//  Created by Junyang Huang on 6/9/14.
//

#import <UIKit/UIKit.h>

/**
 *  the view controller to add or edit item to core data
 */
@interface TBITAddAndEditItemViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

//the uuid assoicated with the item
@property (strong, nonatomic) NSString *itemUUID;

@end
