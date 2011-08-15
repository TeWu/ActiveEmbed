require 'active_embedd/active_embedd'
ActiveRecord::Base.send(:extend, ActiveEmbedd::CanEmbedd)
