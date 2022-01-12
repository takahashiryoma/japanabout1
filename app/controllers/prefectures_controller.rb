class PrefecturesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
     @prefecture = current_user.prefectures.build  # form_with 用
    @pagy, @prefectures = pagy(current_user.prefectures.order(id: :desc))
    @pagy, @prefectures = pagy(User.order(id: :desc), items: 25)
    
  end

  def show
    @id = params[:id]
  end
  
  def new
   @prefecture = Prefecture.new
  end

  def create
    @prefecture = Prefecture.new(prefecture_params)
    if @prefecture.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to current_user
    else
      @pagy, @prefectures = pagy(current_user.prefectures.order(id: :desc))
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render :new
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
end
