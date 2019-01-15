class Achievement < ApplicationRecord
  belongs_to :user

  enum privacy: %i[public_access private_access friend_access]

  mount_uploader :cover_image, CoverImageUploader

  validates :title, presence: true
  validates :user, presence: true
  validates :title, uniqueness: {
    scope: :user_id,
    message: "you can't have two achievements with the same title."
  }

  def description_html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(description)
  end

  def silly_title
    "#{title} by #{user.email}"
  end

  def self.by_letter(letter)
    includes(:user).where('title LIKE ?', "#{letter}%").order('users.email')
  end
end
