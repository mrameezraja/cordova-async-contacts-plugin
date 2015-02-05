
#import <Foundation/Foundation.h>
#import <AddressBook/ABAddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <Cordova/CDVPlugin.h>

@interface AsyncContacts

- (void)getContactsAsync:(CDVInvokedUrlCommand*)command;

@end 
