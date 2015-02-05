// Ionic Starter App

// angular.module is a global place for creating, registering and retrieving Angular modules
// 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
// the 2nd parameter is an array of 'requires'
angular.module('starter', ['ionic'])

    .run(function($ionicPlatform, ContactsService) {
        $ionicPlatform.ready(function() {
            // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
            // for form inputs)
            if(window.cordova && window.cordova.plugins.Keyboard) {
                cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
            }
            if(window.StatusBar) {
                StatusBar.styleDefault();
            }
        });
    })

    .service("ContactsService", ['$q', function($q) {

        var getContacts = function(){
            var deferred = $q.defer();

            if(window.plugins && window.plugins.asyncContacts) {
                window.plugins.asyncContacts.get(function(contacts){
                    //console.log(contacts);
                    deferred.resolve(JSON.parse(contacts));
                }, function(err){
                        deferred.reject("contacts error: " + err);
                });
                
            } else {
                    deferred.reject("No contacts in desktop browser");
            }

            return deferred.promise;
        }
        
        return {
            getContacts: getContacts
        };
    }])

    .controller("AppCtrl", ['$scope', 'ContactsService', function($scope, ContactsService) {

        $scope.data = {
            contacts:[]
        };
        
        $scope.getContacts = function(){
            ContactsService.getContacts().then(function(contacts) {
                $scope.data.contacts = contacts;
            }, function(error){
                alert(error);
            });
        }
        
        $scope.getItemHeight = function(item, index) {
            return 60;
        };
        
        $scope.reset = function(){
            $scope.data.contacts = [];
        }

    }])