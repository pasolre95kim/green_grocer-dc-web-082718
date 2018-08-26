def consolidate_cart(cart)
  # code here
  result = {}
  # code here
  cart.each_with_index do |item, i|
    item.each do |food, info|
      if result[food]
        result[food][:count] += 1
      else
        result[food] = info
        result[food][:count] = 1
      end
    end
  end
  result
end

def apply_coupons(cart, coupons)
  # code here
  result = {}
  # code here#
  cart.each do |food, info|
    coupons.each do |coupon|
      if food == coupon[:item] && info[:count] >= coupon[:num]
        info[:count] =  info[:count] - coupon[:num]
        if result["#{food} W/COUPON"]
          result["#{food} W/COUPON"][:count] += 1
        else
          result["#{food} W/COUPON"] = {:price => coupon[:cost], :clearance => info[:clearance], :count => 1}
        end
      end
    end
    result[food] = info
  end
  result
end


def apply_clearance(cart)
  # code here
  clearance_cart = {}
  # code here
  cart.each do |food, info|
    clearance_cart[food] = {}
    if info[:clearance] == true
      clearance_cart[food][:price] = info[:price] * 4 / 5
    else
      clearance_cart[food][:price] = info[:price]
    end
    clearance_cart[food][:clearance] = info[:clearance]
    clearance_cart[food][:count] = info[:count]
  end
  clearance_cart
end

def checkout(cart, coupons)

  grand_total = 0
#  consolidated_cart = consolidate_cart(cart: cart)
#  cart_with_coupons = apply_coupons(cart: consolidated_cart, coupons: coupons)
#  discounted_cart = apply_clearance(cart: cart_with_coupons)
  discounted_cart = apply_clearance(cart: apply_coupons(cart: consolidate_cart(cart: cart), coupons: coupons))
  discounted_cart.values.each {|pricing| grand_total += pricing[:price]*pricing[:count]}
  grand_total > 100 ? (grand_total*0.9).round(6) : grand_total
end
