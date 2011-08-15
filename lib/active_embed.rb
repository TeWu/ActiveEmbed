require 'active_embed/active_embed'

class ActiveRecord::Base
  extend ActiveEmbed::CanEmbed
end
