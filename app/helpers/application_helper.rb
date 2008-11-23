module ApplicationHelper

  def in_place_rename(element_id, update_url)
    html = link_to_function("Rename", {:id => "edit_#{element_id}"}) 
    html += javascript_tag(in_place_rename_js(element_id, update_url))
  end

  def in_place_rename_js(element_id, update_url)
    "new Ajax.InPlaceEditor('#{element_id}','#{update_url}',
           {
             ajaxOptions: { method: 'put'},
             paramName: 'name',
             externalControl: 'edit_#{element_id}',
             externalControlOnly: true,
             onComplete: null,
             callback:function(form){
               return Form.serialize(form)
                 + '&authenticity_token='
                 + encodeURIComponent('#{form_authenticity_token}');
             }
           })"
  end
end
