class UsersController < ApplicationController

    before_action :authenticate_user!

  # アカウント設定画面
  def account
    @user = current_user
  end

  # プロフィール設定画面
  def profile
    @user = current_user
  end

  # プロフィール編集画面
  def edit
    @user = current_user
  end

  # プロフィール更新
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_user_path(@user), notice: 'プロフィールが更新されました。'
    else
      flash[:alert] = "更新に失敗しました"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :icon)
  end
end

