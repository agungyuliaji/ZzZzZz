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

  validates :name, presence: true
  validate :validate_clock_out_time

  def sleep!(sleep_time = Time.now)
    update(clock_in_time: sleep_time)
  end

  def wake_up!(wake_up_time = Time.now)
    update(clock_out_time: wake_up_time)
  end

  def reset!
    update(
      clock_in_time: nil,
      clock_out_time: nil
    )
  end

  private

  def validate_clock_out_time
    return errors.add(:clock_out_time, "clock_in_time is blank") if clock_in_time.blank? && clock_out_time.present?
    return errors.add(:clock_out_time, "must be after clock_in_time") if clock_in_time.present? && clock_out_time.present? && (clock_out_time < clock_in_time)
  end
end
