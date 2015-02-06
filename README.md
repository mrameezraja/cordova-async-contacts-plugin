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

AsyncContacts Plugin
====================

Load contacts from iOS address book asynchronously (upto 15000 contacts in ~5-10 seconds)
for ios only

cordova plugin https://github.com/mrameezraja/cordova-async-contacts.git


Methods
-------
- addressbook.getAsync


addressbook.getAsync
=================

  window.plugins.addressbook.getAsync(function(contacts){
      console.log(contacts.length);
  }, function(error){
    console.log(error);
  })


Supported Platforms
-------------------

- iOS
