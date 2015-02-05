
var AsyncContacts = function() {

};

AsyncContacts.prototype.get = function(successCallback, errorCallback){
    cordova.exec(successCallback, errorCallback, "AsyncContacts", "getContactsAsync");
}

if(!window.plugins) {
    window.plugins = {};
}
if (!window.plugins.asyncContacts) {
    window.plugins.asyncContacts = new AsyncContacts();
}

if (typeof module != 'undefined' && module.exports) {
  module.exports = AsyncContacts;
}
