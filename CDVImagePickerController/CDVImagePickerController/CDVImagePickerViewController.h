//
//  CDVImagePickerViewController.h
//  CDVImagePickerController
//
//  Created by alex on 05.09.15.
//  Copyright © 2015 Codeveyor. All rights reserved.. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CDVImagePickerViewControllerButton) {
    CDVImagePickerViewControllerButtonPhoto = 1,
    CDVImagePickerViewControllerButtonAlbum = 2,
    CDVImagePickerViewControllerButtonReset = 3
};

/**
 Delegate protocol for handling additional actions as tapped image etc. See delegate's methods list
 */
@protocol CDVImagePickerViewControllerDelegate;

/**
 Delegate protocol for handling simple getting and reseting image
 */
@protocol CDVImagePickerViewControllerActionsDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface CDVImagePickerViewController : UIViewController

@property (nonatomic, weak) id <CDVImagePickerViewControllerDelegate> delegate;
@property (nonatomic, weak) id <CDVImagePickerViewControllerActionsDelegate> actionsDelegate;

/**
 Loads imagePicker with existing image.
 
 @param image Image for displaying if it is already exists.
 */
- (void)loadImagePickerWithImage:(nullable UIImage *)image;

/**
 Loads imagePicker with existing image and text for search image in web.
 
 @param image Image for displaying if it is already exists.
 @param searchText Search request text to be used in Google Images API. Pass nil if not plan to use possibility to search image in web
 */
- (void)loadImagePickerWithImage:(nullable UIImage *)image
                      searchText:(nullable NSString *)searchText;

@end

@protocol CDVImagePickerViewControllerDelegate <NSObject>
@required
- (void)resetImage;
- (void)setChosenImage:(nonnull UIImage *)image;
@end

@protocol CDVImagePickerViewControllerActionsDelegate <NSObject>
@optional
- (void)imagePickerDidTapped;
- (void)imagePickerButtonDidPressed:(nonnull UIButton *)button;
- (void)imagePickerDidFinishPickingMediaWithInfo;
- (void)imagePickerDidCancel;
@end

NS_ASSUME_NONNULL_END