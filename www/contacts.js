
var AsyncContacts = function() {

};

AsyncContacts.prototype.getAsync = function(successCallback, errorCallback){
    var onsuccess = function(contacts){
      successCallback(JSON.parse(contacts));
    }
    cordova.exec(onsuccess, errorCallback, "AsyncContacts", "getContactsAsync");
}

/*if(!window.plugins) {
    window.plugins = {};
}
if (!cordova.plugins.contacts) {
   cordova.plugins.contacts = new AsyncContacts();
}*/

if (typeof module != 'undefined' && module.exports) {
  module.exports = AsyncContacts;
}
