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

      content_tag(:div, class: "w-100") do
        content_tag(:div, class: container_classes) do
          super(name, options) + text_field_label(name, options)
        end + help_text(options) + error_msg(name)
      end
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

  def submit(value = nil, options = {}, &block)
    options[:class] = "#{options[:class]} mdc-button"
    options[:type] = "submit"

    content_tag(:button, value || submit_default_value, options, &block)
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
