
AsyncContacts Plugin
====================

Load contacts from iOS address book asynchronously (upto 15000 contacts in ~5-10 seconds)

This plugin is inspired from github.com/Alterplay/APAddressBook.

<pre><code>cordova plugin add https://github.com/mrameezraja/cordova-async-contacts.git</code></pre>


Methods
-------
- addressbook.getAsync
- addressbook.checkPermission


addressbook.getAsync
=================

<pre>
<code>
  window.plugins.addressbook.getAsync(function(contacts){
      console.log(contacts.length);
  }, function(error){
    console.log(error);
  })
</code>
</pre>

Available fields:
- firstName
- middleName
- lastName
- phones

addressbook.checkPermission
=================

<pre>
<code>
  window.plugins.addressbook.checkPermission(function(permission){
      console.log(permission);
  }, function(error){
    console.log(error);
  })
</code>
</pre>


Supported Platforms
-------------------

- iOS
