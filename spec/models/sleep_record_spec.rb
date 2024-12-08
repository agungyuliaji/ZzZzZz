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
require 'rails_helper'

RSpec.describe SleepRecord, type: :model do
  let(:user) { create(:user) }

  describe 'callbacks' do
    context '#calculate_duration' do
      it 'calculates duration before create' do
        sleep_record = build(:sleep_record, user: user)
        sleep_record.save
        expect(sleep_record.duration).to eq(28800) # 8 hours in seconds
      end
    end
  end
end
