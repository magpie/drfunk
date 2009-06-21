function textHeight(text, charsWide) {
  var lineHeight = 15.6;
  var lines = 0; 
  text.split('\n').each(function(line) {
    if (line.length > charsWide)
    {
      lines += Math.ceil(line.length / charsWide);
    }  
    else
    {
       lines += 1;
    }
  });
  return lines * lineHeight;
}

var ResizingStep = Class.create({ 
  initialize: function(area1, area2) {
    this.area1 = area1;
    this.area2 = area2;
    this.resizeEvent = this.resizeEvent.bindAsEventListener(this);
    Event.observe(area1, "keyup", this.resizeEvent);
    Event.observe(area2, "keyup", this.resizeEvent);
    this.resize();
  },

  resizeEvent: function(event) {
     this.resize(); 
  },

  resize: function() {
    var height = this.stepHeight();
    this.area1.setStyle({'height':height + 'px'});
    this.area2.setStyle({'height':height + 'px'});
  },
  
  stepHeight: function() {
    var minHeight = 100;
    var firstHeight = textHeight(this.area1.value, 35.0);
    var secondHeight = textHeight(this.area2.value, 35.0);

    biggestHeight = Math.max(firstHeight, secondHeight);

    return Math.max(biggestHeight, minHeight);
  } 
});

var ResizingSetup = Class.create({
  initialize: function(area1) {
    this.area1 = area1;
    this.resizeEvent = this.resizeEvent.bindAsEventListener(this);
    Event.observe(area1, "keyup", this.resizeEvent);
    this.resize();
  },

  resizeEvent: function(event) {
     this.resize(); 
  },

  resize: function() {
    var height = this.setupHeight();
    this.area1.setStyle({'height':height + 'px'});
  },
  
  setupHeight: function() {
    var minHeight = 100;
    var sHeight = textHeight(this.area1.value, 78.0);

    return Math.max(sHeight, minHeight);
  } 
});
