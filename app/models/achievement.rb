class Achievement < ApplicationRecord
  belongs_to :user

  enum privacy: %i[public_access private_access friend_access]

  validates :title, presence: true
  validates :user, presence: true
  validates :title, uniqueness: {
    scope: :user_id,
    message: "you can't have two achievements with the same title."
  }

  def description_html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(description)
  end
end
