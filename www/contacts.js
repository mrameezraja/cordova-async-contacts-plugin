
var AsyncContacts = function() {

};

AsyncContacts.prototype.getAsync = function(successCallback, errorCallback){
    var onsuccess = function(contacts){
      successCallback(JSON.parse(contacts));
    }
    cordova.exec(onsuccess, errorCallback, "AsyncContacts", "getContactsAsync");
}

AsyncContacts.prototype.checkPermission = function(successCallback, errorCallback){
    cordova.exec(successCallback, errorCallback, "AsyncContacts", "checkAccess");
}


if(!window.plugins) {
    window.plugins = {};
}
if (!window.plugins.addressbook) {
  window.plugins.addressbook = new AsyncContacts();
}

if (typeof module != 'undefined' && module.exports) {
  module.exports = AsyncContacts;
}
