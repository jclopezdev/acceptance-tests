require 'rails_helper'
require_relative '../pages/login_form'
require_relative '../pages/new_achievement_form'

feature 'create new achievement' do
  let(:new_achievement_form) { NewAchievementForm.new }
  let(:login_form) { LoginForm.new }
  let(:user) { FactoryBot.create(:user) }

  background do
    login_form.visit_page.login_as(user)
  end

  scenario 'create new achievement with valid data' do
    new_achievement_form.visit_page.fill_in_with(
      title: 'Read a book',
      cover_image: 'test.png'
    ).submit

    expect(ActionMailer::Base.deliveries.count).to eq(1)
    expect(ActionMailer::Base.deliveries.last.to).to include(user.email)

    expect(Achievement.last.cover_image_identifier).to eq('test.png')
    expect(page).to have_content('Achievement has been created')
    expect(Achievement.last.title).to eq('Read a book')
  end

  scenario 'cannot create achievement with invalid data' do
    new_achievement_form.visit_page.submit

    expect(page).to have_content("can't be blank")
  end
end
