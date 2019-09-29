def consolidate_cart(item)
  final = Hash.new 0 
  count = :count
item.each do |hash|
  hash.each do |food, description|
  
if final.has_key?(food) == false
  final[food] = description
  final[food][:count] = 1
elsif final.has_key?(food)
final[food][:count] +=1
end
end
end
final
end

def apply_coupons(cart, coupons)
 coupons.each do |coupon|
   item = coupon[:item]
   if cart.has_key?[item]
     if cart[:item][:count] >= coupon[:num]
       if cart[item]  && !cart.has_key?["#{item} W/COUPON"]
          cart["#{item} W/COUPON"] = {price: coupon[:cost] / coupon[:num], clearance: cart[item][clearance:], count: coupon[:num] }
       else
           cart["#{item} W/COUPON"][:count] += coupon[:num]
       end
       cart[item][:count] -= coupon[:num]
     end
    end
   end
   cart
 end

def apply_clearance(cart)
 cart.each do |product_name, stats|
   stats[:price] -= stats[:price] * 0.2 if stats[:clearance]
end
cart
end

def checkout(array, coupons)
  hash_cart = consolidate_cart(array)
  applied_coupons = apply_coupons(hash_cart, coupons)
  applied_discount = apply_clearance(applied_coupons)
 total = applied_discount.reduce(0) { |acc, (key, value)| acc += value[:price] * value[:count] }
 total > 100 ? total * 0.9 : total
end
