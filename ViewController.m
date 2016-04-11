//
//  ViewController.m
//  JsonWebService
//
//  Created by Tops on 12/23/15.
//  Copyright (c) 2015 Tops. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize txt_state,txt_city,img_vw,txt_fnm,txt_nm,txt_unm,txt_upass;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    arrst=[[NSArray alloc]init];
    pkrst=[[UIPickerView alloc]init];
    pkrst.dataSource=self;
    pkrst.delegate=self;
    [txt_state setInputView:pkrst];
    
    txt_city.delegate=self;
    arrct=[[NSArray alloc]init];
    pkrct=[[UIPickerView alloc]init];
    pkrct.dataSource=self;
    pkrct.delegate=self;
    [txt_city setInputView:pkrct];
    
    uclass=[[UrlClass alloc]init];
    uclass.delegate=self;
    [uclass ConnectWithUrl:@"http://ios8192014.somee.com/webservice.asmx/JsonCrud1GetAllStates" Flag:@"state"];
}
-(void)GetUrlData:(NSArray *)arrget Flag:(NSString *)stflag
{
    if ([stflag isEqual:@"state"])
    {
        arrst=arrget;
        [pkrst reloadAllComponents];
    }
    else if ([stflag isEqual:@"city"])
    {
        arrct=arrget;
        [pkrct reloadAllComponents];
    }
}
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger index=0;
    if (pickerView==pkrst)
    {
        index=arrst.count;
    }
    else if (pickerView==pkrct)
    {
        index=arrct.count;
    }
    return index;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *index=@"";
    if (pickerView==pkrst)
    {
        index=[[arrst objectAtIndex:row]objectForKey:@"state_nm"];
    }
    else if (pickerView==pkrct)
    {
        index=[[arrct objectAtIndex:row]objectForKey:@"city_nm"];
    }
    return index;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView==pkrst)
    {
        txt_state.text=[[arrst objectAtIndex:row]objectForKey:@"state_nm"];
    }
    else if (pickerView==pkrct)
    {
        txt_city.text=[[arrct objectAtIndex:row]objectForKey:@"city_nm"];
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==txt_city && txt_state.text.length>0)
    {
        NSArray *arr_st_filter=[arrst valueForKey:@"state_nm"];
        
        NSInteger index_st=[arr_st_filter indexOfObject:txt_state.text];
        
        NSString *st_id=[[arrst objectAtIndex:index_st]objectForKey:@"state_id"];
        
        NSString *st_format=[NSString stringWithFormat:@"http://ios8192014.somee.com/webservice.asmx/JsonCrud2GetCityByState?state_id=%@",st_id];
        
        [uclass ConnectWithUrl:st_format Flag:@"city"];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_image_upload:(id)sender
{
    UIImagePickerController *imgpkr=[[UIImagePickerController alloc]init];
    imgpkr.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imgpkr.delegate=self;
    [self presentViewController:imgpkr animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *img=info[UIImagePickerControllerOriginalImage];
    img_vw.image=img;
    //NSLog(@"%@",[self imageToNSString:img_vw.image]);
    
}
- (NSString *)imageToNSString:(UIImage *)image
{
    NSData *data = UIImagePNGRepresentation(image);
    
    return [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}
- (IBAction)btn_submit:(id)sender
{
    
     //NSLog(@"%@",[self encodeToBase64String:img_vw.image]);
    
    NSArray *arr_st_filter=[arrst valueForKey:@"state_nm"];
    NSInteger index_st=[arr_st_filter indexOfObject:txt_state.text];
    NSString *st_id=[[arrst objectAtIndex:index_st]objectForKey:@"state_id"];
    
    NSArray *arr_ct_filter=[arrct valueForKey:@"city_nm"];
    NSInteger index_ct=[arr_ct_filter indexOfObject:txt_city.text];
    NSString *ct_id=[[arrct objectAtIndex:index_ct]objectForKey:@"city_id"];
    
    NSString *st_format=[NSString stringWithFormat:@"http://ios8192014.somee.com/webservice.asmx/JsonCrud3InsertUserData?txt_fnm=%@&txt_lnm=%@&u_st=%@&u_ct=%@&u_photo=%@&u_unm=%@&u_pass=%@",txt_fnm.text,txt_nm.text,st_id,ct_id,[self imageToNSString:img_vw.image],txt_unm.text,txt_upass.text];
    
    [uclass ConnectWithUrl:st_format Flag:@"insert"];
}
@end
