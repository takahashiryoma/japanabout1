class PrefecturesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
     @prefecture = current_user.prefectures.build  # form_with 用
    @pagy, @prefectures = pagy(current_user.prefectures.order(id: :desc))
    @pagy, @prefectures = pagy(User.order(id: :desc), items: 25)
  end

  def show
    @user = User.find(params[:id])
    @want = current_user.wants.build
    @pagy, @wants = pagy(current_user.wants.order(id: :desc), item: 25)
    @prefecture = current_user.prefecture.build
    @pagy, @prefectures = pagy(current_user.prefectures.order(id: :desc), item: 25)
  end

  def new
  end

  def create
    @prefecture = current_user.prefectures.build(prefecture_params)
    if @want.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to user_path
    else
      @pagy, @prefectures = pagy(current_user.prefectures.order(id: :desc))
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      redirect_to root_url
    end
    end
  end

  def destroy
    @prefecture.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: user_path)
  end
  
  private

  def prefecture_params
    params.require(:prefecture).permit(:name,:image,:google_map_url)
  end

  def correct_user
    @prefecture = current_user.prefectures.find_by(id: params[:id])
    unless @prefecture
      redirect_to root_url
    end
end
