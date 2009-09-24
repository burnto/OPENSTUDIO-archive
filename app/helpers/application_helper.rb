# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def piece_image_tag piece, size=300
    content_tag "div", :class => "piece" do 
      image_tag "/os/#{size}/#{piece.legacy_id}.png"
    end
  end
  
end
