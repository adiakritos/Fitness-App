
function thisIsAFunction() {
    // notice that no ; is needed at the end after the }
}

var thisIsALSOaFunction = function() {
    // notice the ; at the end, because its ASSIGNMENT (with an = sign). when you have
    // assignment it must be x = y;
    // this is the preferred way to write a function for a few reasons that will make sense later
};

////

var foo = function() {
    // this is a normal function. nothing will happen at this moment because it's not being called, only defined at this point
    alert('hi');
};

// we can call it from console... but it does NOT execute at the time of definition

// we can also call it from the code itself AFTER it's been defined

// foo();

// watch what happens when you call just 'foo' in console, without quotes, and without the ()
// it will RETURN THE CODE OF THE FUNCTION ITSELF....... thats super important.
// because now you can store functions in variables...
//
// var hello = foo;
//
// there is a second thing thats very important... SELF EXECUTING FUNCTIONS

var sef = (function() {
    //alert('this is a self executing function. it happens at the time of definition');
})();

// this brings us to why you want to use both of these to your advantage to create modular code in your app

var foods = (function() {

    // now this scope is AUTO executed...

    console.log('initializing all foods functions');

    var outputOranges = function() {
        console.log('but look at this... isnt this nice.. we dont have to automatically execute this...')
        /// unless we want to call it directly
    };

    return {
        outputOranges: outputOranges
    }
})();

// nothing happens..... because we are only defining
//
// why dont we try calling the oranges function inside the foods function...
//
// we CANNOT ACCESS THE INNER FUNCTIOn... BECAUSE ITS --PRIVATE--
//
// in order to make it a --PUBLIC-- method, we need to return it
//
// now we can access stuff INSIDE the function.. now instead of outputting a string..... lets call a function

// once again you can see we need () to execute it and not return the function itself
//
// one other thing, you usually name the return key and value the same so it matches the function name
//
// it would be nice if we DIDNT need to execute it ourself every time though. writing foods
//
// we can go back to self executing functions to do this.. because obviously this wont work
//
// one thing i like to do is add an init() function at the bottom of lots of stuff needs to happen.. then i call it ONLY when needed... like this
//
// lets say on the progressLog we want to only initialize it on homepage
