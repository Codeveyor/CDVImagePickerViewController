[![](images/logo_codeveyor.jpg)](https://twitter.com/Codeveyor)

## CDVImagePicker v1.0

`CDVImagePicker` is a fully customizable image picker written in Objective-C. Subclassed from UIViewController

[![](images/preview.png)](http://codeveyor.com)

## Requirements

`CDVImagePicker` uses ARC and requires iOS 7.0+. Works for iPhone and iPad

##Installation

###Cocoapods

###Manual
Drag CDVImagePickerController folder to your project 

##How to use
1.Find Container View at the list of available UI elements in Interface Builder

[![](images/1.find_container.png)](http://codeveyor.com)

2.Drag it to view, place and constrain it as you wish.

[![](images/2.drag_container.png)](http://codeveyor.com)

You will see that actual container created and connectied view scene with Embed Segue. Give a name for a segue

3.Set container class at Identity Inspector tab

[![](images/3.set_container_class.png)](http://codeveyor.com)

4.Add ImageView and buttons in order you wish and constrain them

[![](images/4.constrain_view.png)](http://codeveyor.com)

5.Don't forget to set outlets and actions

[![](images/5.set_outlets.png)](http://codeveyor.com)

6.Subscribe to delegate in your ViewController and define Embed Segue saw before in Storyboard. Use the delegate methods

``` objective-c
@interface ViewController () <CDVImagePickerViewControllerDelegate>
@property (nonatomic, strong) CDVImagePickerViewController *imagePickerViewController;
@end

static NSString * const kImagePickerSegue = @"toImagePicker";

@implementation ViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kImagePickerSegue])
    {
        // setup of view container
        self.imagePickerViewController = (CDVImagePickerViewController *)[segue destinationViewController];
        self.imagePickerViewController.delegate = self;
    }
}

#pragma mark - ImagePicker Delegate

- (void)resetImage
{
    // code for resetting image
}

- (void)setChosenImage:(nonnull UIImage *)image
{
    // code for getting image
}
```

7.Enjoy!

## To Do

- implement DatabaseManager for storing and receiving images from storage
- handling errors in ImagePicker
- implement search image functionality
- properties for customizing appearance
- callback blocks
- improve test coverage
- add pod
- make a Swift version

####Done
- write "How to use" section
- make test app icons

##License
The MIT License (MIT). See `LICENSE` file for more details
 
