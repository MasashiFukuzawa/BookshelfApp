class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :desc, -> {order(created_at: :desc)}
end
