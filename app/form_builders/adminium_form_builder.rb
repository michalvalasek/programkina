class AdminiumFormBuilder < ActionView::Helpers::FormBuilder

	def text_field(name, options={})
		css_class = "text"
		css_class += " error" unless @object.errors[name].empty?
		options.reverse_merge! size: 100, class: css_class
		super
	end

	def text_area(name, options={})
		options.reverse_merge! rows: 3, cols: 104
		super
	end

	def submit(value=nil, options={})
		options.reverse_merge! class: "submit"
		#@template.content_tag(:div, super, class: "actions")
		super
	end

end