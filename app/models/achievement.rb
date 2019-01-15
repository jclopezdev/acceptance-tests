class Achievement < ApplicationRecord
  belongs_to :user

  enum privacy: %i[public_access private_access friend_access]

  validates :title, presence: true

  def description_html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(description)
  end
end
