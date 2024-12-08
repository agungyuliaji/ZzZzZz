# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  clock_in_time  :datetime
#  clock_out_time :datetime
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class User < ApplicationRecord
  has_many :sleep_records

  # I avoid using HABTM + simple join_table for some cases, the follow and friendship system is one of those cases.
  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow', dependent: :destroy
  has_many :following, through: :following_relationships, source: :followed
  has_many :follower_relationships, foreign_key: :followed_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  validates :name, presence: true
  validate :validate_clock_out_time

  after_save :record_data

  # Sleep Operations
  # ==================================
  def sleep!(sleep_time = Time.current)
    update(clock_in_time: sleep_time)
  end

  def wake_up!(wake_up_time = Time.current)
    update(clock_out_time: wake_up_time)
  end

  def reset!
    update(
      clock_in_time: nil,
      clock_out_time: nil
    )
  end

  # Follows Unfollows
  # ==================================
  def follow(user)
    following_relationships.create(followed_id: user.id) unless self == user || following.include?(user)
  end

  def unfollow(user)
    following_relationships.find_by(followed_id: user.id)&.destroy
  end

  def following?(user)
    following.include?(user)
  end

  private

  def validate_clock_out_time
    # 🚫 sleep! called more than once without wake_up!
    if clock_in_time_changed? && clock_in_time_was.present? && clock_in_time.present?
      return errors.add(:clock_in_time, "#{self.name} already slept at #{clock_in_time_was}")
    end

    # 🚫 wake_up! without sleep!
    if clock_in_time.blank? && clock_out_time.present?
      return errors.add(:clock_out_time, "#{self.name} is awake")
    end

    # 🚫 clock_out_time less than clock_in_time
    if clock_in_time.present? && clock_out_time.present? && (clock_out_time < clock_in_time)
      return errors.add(:clock_out_time, "must be after clock_in_time")
    end
  end

  def record_data
    if clock_in_time.present? && clock_out_time.present?
      self.sleep_records.create!(
        clock_in_time: clock_in_time,
        clock_out_time: clock_out_time
      )
      self.reset!
    end
  end
end
