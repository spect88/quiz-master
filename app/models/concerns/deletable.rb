module Deletable
  extend ActiveSupport::Concern

  included do
    scope :existing, -> { where(deleted_at: nil) }
    scope :deleted, -> { where.not(deleted_at: nil) }
  end

  def mark_as_deleted!
    update!(deleted_at: Time.now)
  end

  def deleted?
    deleted_at.present?
  end
end
