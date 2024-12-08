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
