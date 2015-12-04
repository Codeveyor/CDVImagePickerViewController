//
//  CDVImagePickerControllerTests.m
//  CDVImagePickerControllerTests
//
//  Created by alex on 01.12.15.
//  Copyright © 2015 Codeveyor. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "CDVImagePickerViewController.h"

@interface CDVImagePickerControllerTests : XCTestCase

@property (nonatomic, strong) CDVImagePickerViewController *imagePickerController;

@end

@implementation CDVImagePickerControllerTests

- (void)setUp
{
    [super setUp];
    self.imagePickerController = [CDVImagePickerViewController new];
}

- (void)tearDown
{
    self.imagePickerController = nil;
    [super tearDown];
}

#pragma mark - Passing Data

- (void)testPassNilToImageProperty
{
    [self.imagePickerController loadImagePickerWithImage:nil];
    
    void (^block)() = ^{
        @throw [NSException exceptionWithName:NSGenericException
                                       reason:@"Passed nil image crashed app"
                                     userInfo:nil];
    };
    XCTAssertThrows(block());
}

- (void)testPassNilToSearchProperty
{
    UIImage *imageToPass = [UIImage new];
    [self.imagePickerController loadImagePickerWithImage:imageToPass searchText:nil];
    
    void (^block)() = ^{
        @throw [NSException exceptionWithName:NSGenericException
                                       reason:@"Passed nil searchText crashed app"
                                     userInfo:nil];
    };
    XCTAssertThrows(block());
}

- (void)testPassNilToImagePropertyAndPassNilToSearchProperty
{
    UIImage *imageToPass = [UIImage new];
    [self.imagePickerController loadImagePickerWithImage:imageToPass searchText:nil];
    
    void (^block)() = ^{
        @throw [NSException exceptionWithName:NSGenericException
                                       reason:@"Passed nil image and nil searchText crashed app"
                                     userInfo:nil];
    };
    XCTAssertThrows(block());
}

@end
