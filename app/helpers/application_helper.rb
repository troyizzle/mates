module ApplicationHelper
  def display_user_avatar(user, size = 40)
    return default_image_avatar unless user.present?

    return unless user&.profile&.avatar&.attached?

    image_avatar(user.profile.avatar.variant(resize: "#{size}x#{size}!"))
  end

  private

  def default_image_avatar(_size = 40)
    image_avatar(asset_path('default.png'))
  end

  def image_avatar(img, _size = 40)
    image_tag img, class: 'h-8 w-8 rounded-full'
  end
end
