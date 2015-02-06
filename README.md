# cordova-async-contacts
Load contacts from iOS address book asynchronously (upto 15000 contacts in ~5-10 seconds)
for ios only

developed using github.com/Alterplay/APAddressBook.

Installation:
  cordova plugin add https://github.com/mrameezraja/cordova-async-contacts.git
  
Usage:

  window.plugins.asyncContacts.get(function(contacts){
      console.log(contacts);
  }, function(err){
      console.log(err);
  });
