# frozen_string_literal: true

module ApplicationHelper
  def fab(link, icon = "add")
    button_classes = "mdc-fab material-icons new-fab app-fab--absolute"

    link_to link, class: button_classes, "data-mdc-auto-init" => "MDCRipple" do
      content_tag(:span, icon, class: "mdc-fab__icon")
    end
  end
end
