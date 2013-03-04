module ApplicationHelper

  # Creates a alert based on bootstrap
  # possible types are: 'block', 'success', 'error' or 'info'
  # options hash can be used to create an additional button by setting:
  # :content as button text
  # :href as buttons link
  # :class as class
  # :method as get, post, delete or update
  def create_alert_field(type, title = nil, message = nil, options = {})
    t1 = content_tag :h4, title
    t2 = content_tag :h5, message
    bb = button_to(options[:content], options[:href], :class => options[:class], :method => options[:method]) unless options == nil || options.empty?
    t3 = content_tag :a, 'x', :class => 'close', :'data-dismiss' => 'alert'
    t1 = t1.concat(bb)
    t4 = t1.concat(t2)
    t5 = t3.concat(t4)

    content_tag :div, t5, :class => "alert alert-#{type}"
  end


end
