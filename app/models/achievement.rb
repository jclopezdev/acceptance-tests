class Achievement < ApplicationRecord
  enum privacy: %i[public_access private_access friend_access]

  validates :title, presence: true
end
