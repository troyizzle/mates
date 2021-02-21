# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user
  validates :user, presence: true

  has_one_attached :avatar

  def update_from_discord(info)
    attach_remote_avatar(info['image'])
    self.first_name = info['name']
    save if user_id.present?
  end

  def avatar_on_disk
    return unless avatar&.attached?

    ActiveStorage::Blob.service.send(:path_for, avatar.key)
  end

  private

  def attach_remote_avatar(uri)
    return if uri.blank?

    avatar.attach(io: URI.open(uri), filename: "avatar#{uri}")
  end
end
