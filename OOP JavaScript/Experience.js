//Some

// Here is an example of OOP using JavaScript

var Experience = function (level) {
  this.level = level;
};

Experience.prototype.MyLevel = function() {
  console.log("Hello, my code experience is " + this.level);
};

var experience = new Experience("Good");

experience.MyLevel;