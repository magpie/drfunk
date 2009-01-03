// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var ho;

Event.observe(window, 'load', onWindowLoad);
Event.observe(window, 'click', function(){ho.clear()});


function onWindowLoad(event) {
  ho = new HoverObserver("scenario");
}

var HoverObserver = Class.create({
  initialize: function(css_class){
    this.css_selector = "." + css_class;
    this.start();
  },
  
  start: function() {
    $$(this.css_selector).each(function(scenario) {
      scenario.observe('mouseover', function(){this.addClassName('active');});
      scenario.observe('mouseout', function(){this.removeClassName('active');});
    }); 
    
  },

  stop: function() {
    $$(this.css_selector).each(function(scenario) {
      scenario.stopObserving('mouseover');
      scenario.stopObserving('mouseout');
    }); 

  },

  clear: function(scenario_name) {
    $$(this.css_selector).each(function(scenario) {
      scenario.removeClassName('active');
    }); 
  }

});
