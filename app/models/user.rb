# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

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
