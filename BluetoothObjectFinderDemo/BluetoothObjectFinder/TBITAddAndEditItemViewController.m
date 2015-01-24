//
//  TBITAddItemViewController.m
//  BluetoothObjectFinder
//
//  Created by Junyang Huang on 6/9/14.
//

#import "TBITAddAndEditItemViewController.h"
#import "TBITAppDelegate.h"


@interface TBITAddAndEditItemViewController ()

@property (atomic) BOOL addMode;
@property (atomic) BOOL editMode;
//specify if user took a photo yet
@property (atomic) Boolean PhotoTaken;

@end

@implementation TBITAddAndEditItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.PhotoTaken = NO;
    self.saveButton.layer.cornerRadius = 10;
    self.saveButton.layer.borderWidth = 0.5;
    self.saveButton.layer.borderColor = [UIColor blueColor].CGColor;
    
    Item *item = [Item MR_findFirstByAttribute:@"uuid" withValue:self.itemUUID];
    if (item)
    {
        self.addMode = NO;
        self.editMode = YES;
        
        [self.nameTextField setText:item.name];
        [self.navigationItem setTitle:@"Edit Item"];
        
        //read from the core data
        ItemPhoto *photo =  [ItemPhoto MR_findFirstByAttribute:@"uuid" withValue:self.itemUUID];
        if (photo&&photo.data)
        {
            UIImage *img = [UIImage imageWithData:photo.data];
            [self.imageButton setImage:img forState:UIControlStateNormal];
        }
    }
    else
    {
        self.addMode = YES;
        self.editMode = NO;
        
        [self.navigationItem setTitle:@" Add Item"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

/**
 *  dismiss UIKeyboard when user clicks off the keyboard
 */
- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    [self.nameTextField resignFirstResponder];
}

/**
 *  gives user the option of selecting a photo from the their library or take a new photo if their device is capable.
 */
- (IBAction)photoChooseButtonClicked:(id)sender
{
    //check if camera is available
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIActionSheet *menu = [[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"choose from gallery",  nil];
        [menu showInView:self.view];
        
    }else
    {
        UIActionSheet *menu = [[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"choose from gallery", @"take a photo", nil];
        [menu showInView:self.view];
    }
}



- (IBAction)pickedCamera:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)pickedLibrary:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //choose from gallarrey
        [self pickedLibrary:nil];
    }
    else if (buttonIndex == 1)
    {
        //take a photo
        [self pickedCamera:nil];
    }
}

/**
 *  Displays the user's library and allows them to pick a picture which will then be turned into a thumbnail.
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //extracting image from the picker and saving it
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"])
    {
        //save image to library if user took a picture.
        UIImage *pickedImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        
        
        float size;
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        {
            size = 450;
        }else
        {
            size = 200;
        }
        
        //convert to thumbnail
        //http://beageek.biz/how-to-create-thumbnail-uiimage-xcode-ios/
        UIImage *originalImage = pickedImage;
        CGSize destinationSize = CGSizeMake(size, size);
        UIGraphicsBeginImageContext(destinationSize);
        [originalImage drawInRect:CGRectMake(0,0,destinationSize.width,destinationSize.height)];
        UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [self.imageButton setImage:thumbnail forState:UIControlStateNormal];
        
        self.PhotoTaken = YES;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 * save the add/edition action to core data and then dismmis the view controller
 */
- (IBAction)saveButtonClicked:(UIButton *)sender
{
    //name checking
    if ([self.nameTextField.text length] < 3)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Item's Name Should Be At Least 3 Letters" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    
    Item *item = [Item MR_findFirstByAttribute:@"uuid" withValue:self.itemUUID];
    
    if (item)
    {
        //overwrite the existing one
        item.name = self.nameTextField.text;
    }else
    {
        item = [Item MR_createEntity];
        item.name = self.nameTextField.text;
        item.uuid = self.itemUUID;
    }
    
    
    if (self.PhotoTaken)
    {
        
        //also save the photo
        NSData *imageData = UIImagePNGRepresentation(self.imageButton.imageView.image);
        ItemPhoto *photo = [ItemPhoto MR_findFirstByAttribute:@"uuid" withValue:self.itemUUID];
        if(photo)
        {
            photo.data = imageData;
        }else
        {
            photo = [ItemPhoto MR_createEntity];
            photo.uuid = self.itemUUID;
            photo.data = imageData;
        }
    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    //go back to the previous page
    [self.navigationController popViewControllerAnimated:YES];
}

//dismisses UIKeyboard after user hits return
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self.nameTextField resignFirstResponder];
    return YES;
}
@end
