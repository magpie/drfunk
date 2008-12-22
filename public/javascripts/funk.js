var ho;

Event.observe(window, 'load', onWindowLoad);
Event.observe(window, 'click', function(){ho.start()});


function onWindowLoad(event) {
  ho = new HoverObserver("scenario");
}

var HoverObserver = Class.create({
  initialize: function(css_class){
    this.css_selector = "." + css_class;
    this.start();
  },
  
  start: function() {
    scenario_elements = $$(this.css_selector);
    scenario_elements.each(function(scenario) {
      scenario.removeClassName('active');
      scenario.observe('mouseover', function(){this.addClassName('active');});
      scenario.observe('mouseout', function(){this.removeClassName('active');});
    }); 
    
  },

  stop: function() {
    scenario_elements = $$(this.css_selector);
    scenario_elements.each(function(scenario) {
      scenario.stopObserving('mouseover');
      scenario.stopObserving('mouseout');
    }); 

  }
  
});
