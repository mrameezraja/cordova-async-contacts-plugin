cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
    {
        "file": "plugins/com.plugins.asynccontacts/www/contacts.js",
        "id": "com.plugins.asynccontacts.contacts",
        "clobbers": [
            "AsyncContacts"
        ]
    }
];
module.exports.metadata = 
// TOP OF METADATA
{
    "com.plugins.asynccontacts": "0.0.1"
}
// BOTTOM OF METADATA
});