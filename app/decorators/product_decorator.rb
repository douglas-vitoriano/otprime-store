class ProductDecorator < SimpleDelegator
  def full_promo
    if promo?
      "<span class=\"text-muted text-decoration-line-through\"> #{ActionController::Base.helpers.number_to_currency(price, unit: "R$", precision: 2)}
      </span>  #{ActionController::Base.helpers.number_to_currency(promo_price, unit: "R$", precision: 2)}".html_safe
    else
      ActionController::Base.helpers.number_to_currency(price, unit: "R$", precision: 2)
    end
  end
end
