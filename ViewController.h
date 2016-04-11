//
//  ViewController.h
//  JsonWebService
//
//  Created by Tops on 12/23/15.
//  Copyright (c) 2015 Tops. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlClass.h"

@interface ViewController : UIViewController<UrlProtocol,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UrlClass *uclass;
    NSArray *arrst;
    UIPickerView *pkrst;
    
    NSArray *arrct;
    UIPickerView *pkrct;
}
@property (weak, nonatomic) IBOutlet UITextField *txt_state;
@property (weak, nonatomic) IBOutlet UITextField *txt_city;
@property (weak, nonatomic) IBOutlet UIImageView *img_vw;
- (IBAction)btn_image_upload:(id)sender;
- (NSString *)imageToNSString:(UIImage *)image;
@property (weak, nonatomic) IBOutlet UITextField *txt_fnm;
@property (weak, nonatomic) IBOutlet UITextField *txt_nm;
@property (weak, nonatomic) IBOutlet UITextField *txt_unm;
@property (weak, nonatomic) IBOutlet UITextField *txt_upass;
- (IBAction)btn_submit:(id)sender;
@end

