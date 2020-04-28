class UserController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:sign_in_page, :sign_up_page]

  def sign_in_page
    redirect_to('/', flash: { alert: '이미 로그인되어 있습니다' }) && return if logged_in?

    render 'user/sign_in'
  end

  def sign_out
    if request.method_symbol == :post
      session[:user_id] = nil
      redirect_to '/', flash: { info: '로그아웃 되었습니다' }
    else
      redirect_to '/', flash: { alert: '잘못된 접근입니다' }
    end
  end

  def sign_in
    if request.method_symbol == :post
      user = User.find_by(email: params[:email].downcase)
      if user&.authenticate(params[:password])
        redirect_to('/', flash: { alert: '이메일 주소를 인증해주세요' }) && return unless user&.is_verified?

        user.login_at = Time.now
        user.save
        session[:user_id] = user.id
        redirect_to '/', flash: { info: '로그인 되었습니다' }
      else
        redirect_to '/sign-in', flash: { alert: '이메일 주소나 비밀번호가 일치하지 않습니다' }
      end
    else
      redirect_to '/sign-in', flash: { alert: '잘못된 접근입니다' }
    end
  end

  def sign_up_page
    redirect_to('/', flash: { alert: '이미 가입되어 있습니다' }) && return if logged_in?

    render 'user/sign_up'
  end

  def sign_up
    if request.method_symbol == :post
      user = User.find_by(email: params[:email].downcase)
      redirect_to('/sign-up', flash: { alert: '이미 등록된 E-Mail입니다' }) && return if user

      if params[:password] == params[:password_confirmation]
        created_time = Time.now
        user = User.create(
          email: params[:email],
          password: params[:password],
          password_confirmation: params[:password_confirmation],
          username: params[:username],
          minecraft_username: params[:minecraft_username],
          minecraft_uuid: params[:minecraft_uuid] || '',
          role: User::ROLES[:general],
          created_at: created_time,
          login_at: created_time
        )
        if user.save
          REDIS.set(user.confirmation_token, user.id.to_s)
          UserMailer.with(user: user, token: user.confirmation_token).confirm_email.deliver_later
          redirect_to '/', flash: { alert: '가입 되었습니다. 인증 메일을 확인해주세요' }
        else
          redirect_to '/sign-up', flash: { alert: '입력한 정보가 올바르지 않습니다' }
        end
      else
        redirect_to '/sign-up', flash: { alert: '입력한 정보가 올바르지 않습니다' }
      end
    else
      redirect_to '/sign-up', flash: { alert: '잘못된 접근입니다' }
    end
  end

  def verify_email
    user_id = REDIS.get(params[:token])
    logger.debug user_id
    redirect_to('/', flash: { alert: '인증 정보가 없습니다' }) && return unless user_id

    user_id = user_id.to_i
    logger.debug user_id
    user = User.find user_id
    redirect_to('/', flash: { alert: '대충 문제가 있다는 메시지' }) && REDIS.del(params[:token]) && return unless user

    if user.is_verified
      REDIS.del(params[:token])
      redirect_to '/sign-in', flash: { info: '이미 인증되었습니다' }
    else
      user.is_verified = true
      user.save
      REDIS.del(params[:token])
      redirect_to '/sign-in', flash: { info: '인증되었습니다' }
    end
  end

  def profile_page
    redirect_to('/sign-in', flash: { alert: '로그인 해주세요' }) && return if current_user.nil?

    render 'user/profile'
  end

  def modify_password
    redirect_to('/sign-in', flash: { alert: '로그인 해주세요' }) && return if current_user.nil?

    user = User.find_by(id: current_user.id)
    if user&.authenticate(params[:old_password])
      if params[:password] == params[:password_confirmation]
        user.password_digest = BCrypt::Password.create(params[:password])
        user.save
        redirect_to '/profile', flash: { info: '비밀번호가 변경되었습니다' }
      else
        redirect_to '/profile', flash: { alert: '새 비밀번호가 일치하지 않습니다' }
      end
    else
      session[:user_id] = nil
      redirect_to '/', flash: { alert: '비밀번호가 일치하지 않습니다' }
    end
  end

  def modify_minecraft

  end

  def drop_out
    redirect_to('/sign-in', flash: { alert: '로그인 해주세요' }) && return if current_user.nil?

    user = User.find_by(id: current_user.id)
    if user
      user.delete
      session[:user_id] = nil
      redirect_to '/', flash: { info: '탈퇴 되었습니다' }
    else
      redirect_to '/', flash: { alert: '잘못된 요청입니다' }
    end
  end
end
