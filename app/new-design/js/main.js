
var joocyApp = (function() {

    var progressLog = (function() {

        var refreshProgress = function() {
            // reload progress data
        };

        var saveProgress = function() {
            // ajax save progress
            refreshProgress();
        };

        var init = function() {
            // usually i put all my click handlers in the init function
            $('submit').click(function() {
                saveProgress();
            });
        };

        return {
            init: init
        }
    })();

    var mealCreator = function() {

        // other meal creator JS here
        
        var autocomplete = function() {
            // autocomplete for meal creator
        };
    };

    var init = (function() {
        // initialize the app
    })();

    return {
        progressLog: progressLog
    };

})();

var joocyRouter = (function() {

    var path = window.location.pathname;

    if
    ( /^\/root_path_of_app_regex_here\//i.test(path) ) {
        joocyApp.progressLog.init();
    }
    else if
    ( /^\/path2\//i.test(path) ) {
        // call thing two
    }

})();
