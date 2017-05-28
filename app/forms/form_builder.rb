# frozen_string_literal: true

class FormBuilder < ActionView::Helpers::FormBuilder
  include CollectionSelect

  delegate :content_tag, :tag, to: :@template
  delegate :errors, to: :@object

  %w(text_field email_field number_field password_field).each do |method_name|
    define_method(method_name) do |name, options = {}|
      error_class = "mdc-textfield--invalid" if validate_form? && invalid?

      full_width        = "mdc-textfield--fullwidth" if options[:full_width]
      options[:class]   = "#{options[:class]} mdc-textfield__input"
      container_classes = "mdc-textfield #{error_class} #{full_width}"

      content_tag(:div, class: container_classes) do
        super(name, options) + text_field_label(name, options)
      end + help_text(options) + error_msg(name)
    end
  end

  def text_area(method, options = {})
    label_text = options[:label] || method.to_s.titleize
    text_area_container_classes =
      "mt-3 mdc-textfield mdc-textfield--multiline mdc-textfield--fullwidth"
    options[:class] = "#{options[:class]} mdc-textfield__input"

    content_tag(:div, class: text_area_container_classes) do
      super + label(method, label_text, class: "mdc-textfield__label")
    end
  end

  def radio_button(name, value, options = {})
    label_text = options.delete(:label)
    options[:class] = "#{options[:class]} mdc-radio__native-control"

    content_tag(:div, class: "mdc-radio") do
      super(name, value, options) +
        content_tag(:div, class: "mdc-radio__background") do
          content_tag(:div, nil, class: "mdc-radio__outer-circle") +
          content_tag(:div, nil, class: "mdc-radio__inner-circle")
        end
    end + label("#{name}_#{value}", label_text)
  end

  def submit(value = nil, options = {}, &block)
    options[:class] = "#{options[:class]} mdc-button"
    options[:type] = "submit"

    content_tag(:button, value || submit_default_value, options, &block)
  end

  def multiple_course_select(method, selected: nil)
    select(
      method, [], {}, class: "course-select", multiple: true,
                      data: { selected: selected }
    )
  end

  def switch_field(method, options = {}, checked_val = "1", unchecked_val = "0")
    options[:class] = "#{options[:class]} mdc-switch__native-control"
    content_tag(:div, class: "layout vertical center-center mt-3") do
      content_tag(:div, class: "mdc-switch") do
        check_box(method, options, checked_val, unchecked_val) +
        content_tag(:div, class: "mdc-switch__background") do
          content_tag(:div, nil, class: "mdc-switch__knob")
        end
      end + label(method, options[:label], class: "mt-1 mb-2 mdc-switch-label")
    end
  end

  private

  def text_field_label(name, options)
    label_class = "mdc-textfield__label"
    if object.send(name).present?
      label_class += " mdc-textfield__label--float-above"
    end

    label(name, options[:label] || name.to_s.titleize, class: label_class)
  end

  def help_text(options)
    return "" if options[:help_text].blank?

    content_tag(
      :p, options[:help_text],
      class: "mdc-textfield-helptext", "aria-hidden" => true
    )
  end

  def error_msg(name)
    return "" unless object.errors.key?(name)

    content_tag(:p, class: "mdc-textfield-helptext
          mdc-textfield-helptext--persistent
          mdc-textfield-helptext--validation-msg") do
      object.errors[name].first.capitalize
    end
  end

  def invalid?
    (@template.request.post? || @template.request.put?) && object.invalid?
  end

  def validate_form?
    return true unless options.key?(:validation)

    options[:validation]
  end
end
