
#import "AsyncContacts.h"
#import <UIKit/UIKit.h>
#import <Cordova/NSArray+Comparisons.h>
#import <Cordova/NSDictionary+Extensions.h>
//#import "CDVNotification.h"

#import "APContact.h"
#import "APAddressBook.h"

@implementation AsyncContacts

// overridden to clean up Contact statics
- (void)onAppTerminate
{
    // NSLog(@"Contacts::onAppTerminate");
}

/***********************************************************/
// this function return contacts asynchronously
- (void)getContactsAsync:(CDVInvokedUrlCommand*)command
{
    NSLog(@"getContactsAsync...");
    APAddressBook *apaAddressBook = [[APAddressBook alloc] init];

    NSString* callbackId = command.callbackId;
    //NSArray* fields = [command.arguments objectAtIndex:0];
    //NSDictionary* searchFields = [[APContact class] calcReturnFields:fields];

    __weak __typeof(self) weakSelf = self;

    apaAddressBook.fieldsMask = APContactFieldAll;
    apaAddressBook.sortDescriptors = @[
    [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES],
    [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES]];
    apaAddressBook.filterBlock = ^BOOL(APContact *contact)
    {
        return contact.phones.count > 0;
    };
    [apaAddressBook loadContacts:^(NSArray *contacts, NSError *error)
    {
        if (!error)
        {
            //NSLog(@"contacts count: %lu", (unsigned long)[contacts count]);
            NSMutableArray* returnContacts = [NSMutableArray arrayWithCapacity:1];
            int count = (int)[contacts count];
            for(int i = 0; i < count; i++){
                APContact* contact = [contacts objectAtIndex:i];
                NSDictionary *jsonContact = @{
                    @"firstName" : ReplaceSpecialChars(contact.firstName),
                    @"middleName" : ReplaceSpecialChars(contact.middleName),
                    @"lastName" : ReplaceSpecialChars(contact.lastName),
                    @"phones" : contact.phones,
                };

                [returnContacts addObject:jsonContact];
            }
            //NSLog(@"returnContacts: %@", returnContacts);
            NSError *writeError = nil;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:returnContacts options:NSJSONWritingPrettyPrinted error:&writeError];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            //NSLog(@"JSON Output: %@", jsonString);

            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
            [weakSelf.commandDelegate sendPluginResult:result callbackId:callbackId];
        }
        else
        {
            NSLog(@"contacts error: %@", error);
            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageToErrorObject:error];
            [weakSelf.commandDelegate sendPluginResult:result callbackId:callbackId];
            return;
        }
    }];

}

- (void)checkAccess:(CDVInvokedUrlCommand*)command
{
    NSLog(@"checkAccess...");
    NSString* callbackId = command.callbackId;
    NSString* permissionResult = @"";
    __weak __typeof(self) weakSelf = self;

    switch([APAddressBook access])
    {
        case APAddressBookAccessUnknown:
            // Application didn't request address book access yet
            permissionResult = @"ACCESS_NOT_REQUESTED";
            break;

        case APAddressBookAccessGranted:
            // Access granted
            permissionResult = @"ACCESS_GRANTED";
            break;

        case APAddressBookAccessDenied:
            // Access denied or restricted by privacy settings
            permissionResult = @"ACCESS_DENIED";
            break;
    }
    NSLog(@"permissionResult %@", permissionResult);

    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:permissionResult];
    [weakSelf.commandDelegate sendPluginResult:result callbackId:callbackId];
}

-(void)getCount:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = command.callbackId;
    int contactsCount = 0;
    __weak __typeof(self) weakSelf = self;
    APAddressBook *apaAddressBook = [[APAddressBook alloc] init];
    apaAddressBook.fieldsMask = APContactFieldFirstName;
    apaAddressBook.filterBlock = ^BOOL(APContact *contact)
    {
        return contact.phones.count > 0;
    };
    [apaAddressBook loadContacts:^(NSArray *contacts, NSError *error)
    {
        if (!error)
        {
            __block contactsCount = (int)[contacts count];
        }
        else
        {

        }
    }];

    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:contactsCount];
    [weakSelf.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)startObserveChanges:(CDVInvokedUrlCommand*)command
{
    // start observing
    /*[addressBook startObserveChangesWithCallback:^
    {
        NSLog(@"Address book changed!");
    }];
    // stop observing
    [addressBook stopObserveChanges];*/
}

- (void)stopObserveChanges:(CDVInvokedUrlCommand*)command
{
    // start observing
    /*[addressBook startObserveChangesWithCallback:^
    {
        NSLog(@"Address book changed!");
    }];
    // stop observing
    [addressBook stopObserveChanges];*/
}

NSString *ReplaceSpecialChars(NSString *inputString)
{
   NSString* returnString = inputString != nil ? inputString : @"";
   if(inputString != [NSNull null] && [inputString length] > 0){
        NSArray *split = [inputString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        split = [split filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"length > 0"]];
        NSString *res = [split componentsJoinedByString:@" "];
        returnString = res;

    };
    return returnString;
}

@end
