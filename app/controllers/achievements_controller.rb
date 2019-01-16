class AchievementsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_achievement, only: %i[show edit update destroy owners_only]
  before_action :owners_only, only: %i[edit update destroy]

  def index
    @achievements = Achievement.public_access
  end

  def show
  end

  def new
    @achievement = current_user.achievements.new
  end

  def create
    @achievement = current_user.achievements.new(achievement_params)
    if @achievement.save
      UserMailer.achievement_created(current_user.email, @achievement.id).deliver_now
      # tweet = TwitterService.new.tweet(@achievement.title)
      redirect_to achievement_url(@achievement), notice: 'Achievement has been created'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @achievement.update_attributes(achievement_params)
      redirect_to achievement_path(@achievement)
    else
      render :edit
    end
  end

  def destroy
    if @achievement.destroy
      redirect_to achievements_path
    end
  end

  private

  def set_achievement
    @achievement = Achievement.find(params[:id])
  end

  def owners_only
    if current_user != @achievement.user
      redirect_to achievements_path
    end
  end

  def achievement_params
    params.require(:achievement).permit(:title, :description, :privacy, :cover_image, :featured)
  end
end
