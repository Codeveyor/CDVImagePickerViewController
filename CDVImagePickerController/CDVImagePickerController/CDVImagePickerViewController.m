//
//  CDVImagePickerViewController.m
//  CDVImagePickerController
//
//  Created by alex on 05.09.15.
//  Copyright © 2015 Codeveyor. All rights reserved.
//

#import "CDVImagePickerViewController.h"

@interface CDVImagePickerViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIButton *cameraButton;
@property (nonatomic, weak) IBOutlet UIButton *photoLibraryButton;
@property (nonatomic, weak) IBOutlet UIButton *resetButton;
//@property (nonatomic, weak) IBOutlet UIButton *webButton;

@property (nonatomic, strong) UIColor *imageTintColor;
@property (nonatomic, strong) UIColor *cameraButtonTintColor;
@property (nonatomic, strong) UIColor *albumButtonTintColor;
@property (nonatomic, strong) UIColor *resetButtonTintColor;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *searchText;

@property (nonatomic, strong) UIImagePickerController *imagePickerController;

- (IBAction)cameraButtonDidPressed:(UIButton *)button;
- (IBAction)photoLibraryLibraryButtonDidPressed:(UIButton *)button;
- (IBAction)resetButtonDidPressed:(UIButton *)button;
//- (IBAction)webButtonDidPressed:(UIButton *)button;

@end

@implementation CDVImagePickerViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    self.imagePickerController = [UIImagePickerController new];
    self.imagePickerController.delegate = self;
    self.imagePickerController.allowsEditing = YES;
    
    [super viewDidLoad];
    
    [self.cameraButton setTag:CDVImagePickerViewControllerButtoncamera];
    [self.cameraButton setTitle:nil forState:UIControlStateNormal];
    [self.cameraButton setTintColor:[UIColor blackColor]];
    [self.cameraButton setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];

    [self.cameraButton setTag:CDVImagePickerViewControllerButtonAlbum];
    [self.photoLibraryButton setTitle:nil forState:UIControlStateNormal];
    [self.photoLibraryButton setTintColor:[UIColor blackColor]];
    [self.photoLibraryButton setImage:[UIImage imageNamed:@"photo_library"] forState:UIControlStateNormal];
    
    [self.cameraButton setTag:CDVImagePickerViewControllerButtonReset];
    [self.resetButton setTitle:nil forState:UIControlStateNormal];
    [self.resetButton setTintColor:[UIColor blackColor]];
    [self.resetButton setImage:[UIImage imageNamed:@"remove"] forState:UIControlStateNormal];
    
    [self.imageView setTintColor:[UIColor blackColor]];
    self.imageView.image = [UIImage imageNamed:@"empty_image"];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeImageTapped:)];
    [self.imageView setUserInteractionEnabled:YES];
    [tapGestureRecognizer setNumberOfTapsRequired:1];
    [tapGestureRecognizer setDelegate:self];
    [self.imageView addGestureRecognizer:tapGestureRecognizer];
}

#pragma mark - Data

- (void)loadImagePickerWithImage:(UIImage *)image
{
    [self loadImagePickerWithImage:image searchText:nil];
}

- (void)loadImagePickerWithImage:(UIImage *)image
                      searchText:(NSString *)searchText
{
    if (image)
    {
        self.image = image;
        self.imageView.image = image;
    }
    else
    {
        self.imageView.image = [UIImage imageNamed:@"empty_image"];
    }
    
    if (searchText)
    {
        self.searchText = searchText;
    }
}

- (void)imageViewTintColor:(UIColor *)imageViewTintColor
      cameraButtonTintColor:(UIColor *)cameraButtonTintColor
      albumButtonTintColor:(UIColor *)albumButtonTintColor
      resetButtonTintColor:(UIColor *)resetButtonTintColor
{
    if (imageViewTintColor)
    {
        self.imageView.tintColor = imageViewTintColor;
    }
    if (cameraButtonTintColor)
    {
        self.cameraButton.tintColor = cameraButtonTintColor;
    }
    if (albumButtonTintColor)
    {
        self.photoLibraryButton.tintColor = albumButtonTintColor;
    }
    if (resetButtonTintColor)
    {
        self.resetButton.tintColor = albumButtonTintColor;
    }
}

#pragma mark - Actions

- (IBAction)cameraButtonDidPressed:(UIButton *)button
{
    [self.actionsDelegate imagePickerButtonDidPressed:button];
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        NSDictionary *errorDictionary = @{
                                          NSLocalizedDescriptionKey : @"ERROR! Camera is not available at device",
                                          NSLocalizedFailureReasonErrorKey : @"ERROR! Camera is not available at device"
                                          };
        NSError *error = [NSError errorWithDomain:@"error.com.codeveyor" code:0 userInfo:errorDictionary];
        [self.delegate imagePickerReturnedError:error];
        return;
    }
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:self.imagePickerController animated:YES completion:NULL];
}

- (IBAction)photoLibraryLibraryButtonDidPressed:(UIButton *)button
{
    [self.actionsDelegate imagePickerButtonDidPressed:button];
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        NSDictionary *errorDictionary = @{
                                          NSLocalizedDescriptionKey : @"ERROR! camera Library is not available at device",
                                          NSLocalizedFailureReasonErrorKey : @"ERROR! camera Library is not available at device"
                                          };
        NSError *error = [NSError errorWithDomain:@"error.com.codeveyor" code:0 userInfo:errorDictionary];
        [self.delegate imagePickerReturnedError:error];
        return;
    }
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:self.imagePickerController animated:YES completion:NULL];
}

- (IBAction)resetButtonDidPressed:(UIButton *)button
{
    [self.actionsDelegate imagePickerButtonDidPressed:button];
    
    self.image = nil;
    self.imageView.image = [UIImage imageNamed:@"empty_image"];
    [self.delegate resetImage];
    
    [self.cameraButton setTintColor:[UIColor blackColor]];
    [self.photoLibraryButton setTintColor:[UIColor blackColor]];
    [self.resetButton setTintColor:[UIColor blackColor]];
}

#pragma mark - ImagePicker Delegate

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.image = chosenImage;
    self.imageView.image = chosenImage;
    [self.delegate imageDidSelected:chosenImage];
    
    [self.cameraButton setTintColor:[UIColor whiteColor]];
    [self.photoLibraryButton setTintColor:[UIColor whiteColor]];
    [self.resetButton setTintColor:[UIColor whiteColor]];

    [self.actionsDelegate imagePickerDidFinishPickingPhotoLibraryWithInfo];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.actionsDelegate imagePickerDidCancel];

    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (IBAction)webButtonDidPressed:(UIButton *)button
//{
//    
//}

#pragma mark - GestureRecognizer Delegate

- (void)changeImageTapped:(UITapGestureRecognizer *)gesture
{
    [self.actionsDelegate imagePickerDidTapped];
}

@end
