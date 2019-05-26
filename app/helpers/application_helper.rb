module ApplicationHelper
  def product_info(current_product, product)
    case current_product
    when 'ios-apps'
      product['genres'][0]['name']
    when 'itunes-music', 'apple-music', 'audiobooks', 'books'
      product['artistName']
    end
  end
end
