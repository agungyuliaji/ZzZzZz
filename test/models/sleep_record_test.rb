# == Schema Information
#
# Table name: sleep_records
#
#  id             :integer          not null, primary key
#  clock_in_time  :datetime
#  clock_out_time :datetime
#  duration       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer          not null
#
# Indexes
#
#  index_sleep_records_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
require "test_helper"

class SleepRecordTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
