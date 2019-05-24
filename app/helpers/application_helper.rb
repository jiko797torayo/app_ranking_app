module ApplicationHelper
  def product_info(product)
    case controller.controller_name
    when 'free_apps', 'paid_apps'
      product['genres'][0]['name']
    when 'itunes_musics'
      product['artistName']
    end
  end
end
