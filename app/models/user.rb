# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :omniauthable,
         omniauth_providers: %i[discord]

  validates :username, uniqueness: true, presence: true
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile,
                                allow_destroy: true

  def self.from_omniauth(auth)
    case auth['provider']
    when 'discord' then from_discord(auth)
    else
      Rails.logger.info("Unknown auth: #{auth.inspect}")
      nil
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if session['devise.discord_data']
        devise_data = session['devise.discord_data']
        info = devise_data['info']
        user.email = info['email']
        profile = user.build_user_profile
        profile.update_from_discord(info)
      end
    end
  end

  def update_profile(auth)
    p = profile.nil? ? Profile.new(user_id: id) : profile
    case auth['provider']
    when 'discord'
      p.update_from_discord(auth)
    end
  end

  def update_theme(theme)
    profile.update(theme: theme)
  end

  def build_user_profile
    profile.presence || Profile.new(user: self)
  end

  private

  def self.from_discord(auth)
    email = auth.info['email']
    user = User.find_by(email: email)

    user || User.new(email: email)
  end
  private_class_method :from_discord
end
