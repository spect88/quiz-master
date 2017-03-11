class User < ApplicationRecord
  has_many :quizzes, dependent: :destroy

  store_accessor :info, :name, :nickname, :email, :image

  class << self
    def from_auth_hash(auth_hash)
      find_or_initialize_by(
        provider: auth_hash.provider,
        uid: auth_hash.uid
      ).tap do |user|
        user.info = auth_hash.info.to_h
      end
    end
  end
end
