//
//  ViewController.m
//  CDVImagePickerController
//
//  Created by alex on 01.12.15.
//  Copyright © 2015 Codeveyor. All rights reserved.
//

#import "ViewController.h"

#import "CDVImagePickerViewController.h"

@interface ViewController () <CDVImagePickerViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *selectedImageView;
@property (nonatomic, weak) IBOutlet UILabel *actionLabel;

@property (nonatomic, strong) CDVImagePickerViewController *imagePickerViewController;

@end

static NSString * const kImagePickerSegue = @"toImagePicker";

@implementation ViewController

#pragma mark - View Lifecycle

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kImagePickerSegue])
    {
        // setup of view container
        self.imagePickerViewController = (CDVImagePickerViewController *)[segue destinationViewController];
        
        // use one this methods if you want to fill imagePicker with existing image or searchText:
//        [self.imagePickerViewController loadImagePickerWithImage:(nullable UIImage *)];
//        [self.imagePickerViewController loadImagePickerWithImage:(nullable UIImage *) searchText:(nullable NSString *)];
        
        self.imagePickerViewController.delegate = self;
    }
}

#pragma mark - ImagePicker Delegate

- (void)resetImage
{
    self.actionLabel.text = NSLocalizedString(@"Image removed!", nil);
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.selectedImageView.alpha = 0.0f;
    } completion:^(BOOL finished) {
       
        self.selectedImageView.image = nil;
        self.selectedImageView.alpha = 1.0f;
    }];
}

- (void)imageDidSelected:(nonnull UIImage *)image
{
    self.actionLabel.text = NSLocalizedString(@"New image selected!", nil);
    self.selectedImageView.image = image;
}

- (void)imagePickerReturnedError:(NSError *)error
{
    if (error)
    {
        NSLog(@"%@", [error localizedDescription]);
    }
}

@end
