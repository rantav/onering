module FormHelper
  def bootstrap_autocomplete_field(model, association, visible_attribute, hidden_attribute, label, autocomplete_path)
    singularized = model.class.name.tableize.singularize
    visible_input_id = "#{singularized}_#{association}_#{visible_attribute}"
    association_instance = eval "model.#{association}"
    visible_value = association_instance[visible_attribute] unless association_instance.nil?
    hidden_input_id = "#{singularized}_#{association}_#{hidden_attribute}"
    hidden_input_name = "#{singularized}[#{association}_#{hidden_attribute}]"
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