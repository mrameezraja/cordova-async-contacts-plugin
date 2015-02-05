
#import <Foundation/Foundation.h>
#import <AddressBook/ABAddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <Cordova/CDVPlugin.h>

@interface AsyncContacts : CDVPlugin <ABNewPersonViewControllerDelegate,
                         ABPersonViewControllerDelegate,
                         ABPeoplePickerNavigationControllerDelegate
                         >

- (void)getContactsAsync:(CDVInvokedUrlCommand*)command;

@end 
