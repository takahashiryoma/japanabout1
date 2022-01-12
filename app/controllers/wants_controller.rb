class WantsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
     @want = current_user.wants.build  # form_with 用
    @pagy, @wants = pagy(current_user.wants.order(id: :desc))
    @pagy, @users = pagy(User.order(id: :desc), items: 25)
  end

  def show
    @user = User.find(params[:id])
    @want = current_user.wants.build
    @pagy, @wants = pagy(current_user.wants.order(id: :desc), item: 25)
    @prefecture = current_user.prefecture.build
    @pagy, @prefectures = pagy(current_user.prefectures.order(id: :desc), item: 25)
  end

  def new
   @prefecture = Prefecture.new
   @prefecture.wants.build
   @want = Want.new
  end

  def create
    @want = current_user.wants.build(want_params)
    # @prefecture = current_user.prefectures.build(prefecture_params[:prefecture_id])
    if @want.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to current_user
    else
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render :new
    end
  end
  

  def destroy
    @want.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: user_path)
  end
  
  private

  def want_params
    params.require(:want).permit(:content,:prefecture_id)
  end
  
  # def prefecture_params
  #   params.require(:want).permit(prefecture_id:[:name,:image])
  # end

  def correct_user
    @want = current_user.wants.find_by(id: params[:id])
    unless @want
      redirect_to root_url
    end
end
end
