class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
      
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
      
    elsif req.path.match(/cart/)
      if @@cart.empty? 
        "Your cart is empty"
      else 
        @@cart.each do |cart_items|
          resp.write "#{cart_items}\n"
        end
      end
      
    elsif req.path.match(/add/)
      item = req.params["add"]
      if @@items.include?(item)
        @@cart << item
        "added #{item}"
      else 
        return "We don't have that item"
      resp.write add_or_error(add_term)
      
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
