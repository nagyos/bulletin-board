
class UserController < ApplicationController

  def sign_up
    @user = User.new(
      email: params[:email],
      password: params[:password]
    )
    if @user.save
      flash[:notice] = "新規登録が完了しました"
      redirect_to("/")
    else
      render("user/sign_up")
    end
  end

  def sign_in
    @user = User.find_by(email: params[:email])
   if @user && @user.authenticate(params[:password])
     session[:user_id] = @user.id
     flash[:notice] = "ログインしました"
     redirect_to("/posts/index")
   else
     @error_message = "メールアドレスまたはパスワードが間違っています"
     @email = params[:email]
     @password = params[:password]
     render("users/login_form")
   end
  end





end
