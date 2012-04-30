module ApplicationHelper
  def show_extra_attributes(schema, model)
    html = []
    if schema
      schema.entity_attributes.each do |attribute|
        html.push "<p>"
        html.push   "<b>#{attribute.name}:</b> "
        html.push   "#{model[attribute.name]}"
        html.push "</p>"
      end
    end
    html.join.html_safe

  end
end
