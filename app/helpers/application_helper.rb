module ApplicationHelper

  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end
  
  def number_to_locale_currency(number)
    number *= 1.3 if :es == I18n.locale
    number_to_currency number
  end




end
