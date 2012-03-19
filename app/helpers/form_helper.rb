module FormHelper
  def bootstrap_autocomplete_field(model, association, visible_attribute, hidden_attribute, label, autocomplete_path, association_index = -1)
    singularized = model.class.name.tableize.singularize
    visible_input_id = association_index < 0 ? "#{singularized}_#{association}_#{visible_attribute}" : 
        "#{singularized}_#{association}_attributes_#{association_index}_#{visible_attribute}"
    association_instance = eval "model.#{association}"
    association_instance = association_instance[association_index] unless association_index < 0
    visible_value = association_instance[visible_attribute] unless association_instance.nil?
    hidden_input_id = association_index < 0 ? "#{singularized}_#{association}_#{hidden_attribute}" :
        "#{singularized}_#{association}_attributes_#{association_index}_#{hidden_attribute}"
    hidden_input_name = association_index < 0 ? "#{singularized}[#{association}_#{hidden_attribute}]" :
        "#{singularized}[#{association}_attributes][#{association_index}][#{hidden_attribute}]"
    "<div class='string clearfix stringish'>
      <label for='#{visible_input_id}'>#{label}</label>
       <div class='input'>
        <input autocomplete='off' class='typeahead' data-provide='typeahead' id='#{visible_input_id}' type='text' value='#{visible_value}'>
        <input id='#{hidden_input_id}' name='#{hidden_input_name}' type='hidden'>
      </div>
    </div>

    <script>
    $(document).ready(function() {
      $('##{visible_input_id}').typeahead({
        items: 100, 
        source: function (typeahead, query) {
          $.ajax({
           url: '#{autocomplete_path}?term=' + query,
            success: function (data) {
              typeahead.process(data)
            }
          })
        },
        property: 'value',
        onselect: function(obj) {
          $('##{hidden_input_id}').val(obj.id)
        }
      }).change(function (e) {
        var value = $(e.target).val();
        if (value == '') {
          $('##{hidden_input_id}').val('');
        };
    })
  });
  </script>".html_safe()
  end
end