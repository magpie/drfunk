# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

 # taken from:
 # http://blog.codahale.com/2006/01/14/a-rails-howto-simplify-in-place-editing-with-scriptaculous/
 def editable_content(options)
   options[:content] = { :element => 'span' }.merge(options[:content])
   options[:url] = {}.merge(options[:url])
   options[:ajax] = { :okText => "'Save'", :cancelText => "'Cancel'"}.merge(options[:ajax] || {})
   script = Array.new
   script << "new Ajax.InPlaceEditor("
   script << "  '#{options[:content][:options][:id]}',"
   script << "  '#{url_for(options[:url])}',"
   script << "  {"
   script << options[:ajax].map{ |key, value| "#{key.to_s}: #{value}" }.join(", ")
   script << "  }"
   script << ")"

   content_tag(
     options[:content][:element],
     options[:content][:text],
     options[:content][:options]
   ) + javascript_tag( script.join("\\n") )
 end

end
