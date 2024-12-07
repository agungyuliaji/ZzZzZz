require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { User.new(name: "John Doe") }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include("can't be blank")
    end

    it 'is not valid if clock_out_time is present and clock_in_time is blank' do
      subject.clock_out_time = Time.current
      expect(subject).to_not be_valid
      expect(subject.errors[:clock_out_time]).to include("clock_in_time is blank")
    end

    it 'is not valid if clock_out_time is before clock_in_time' do
      subject.clock_in_time = Time.current
      subject.clock_out_time = Time.current - 1.hour
      expect(subject).to_not be_valid
      expect(subject.errors[:clock_out_time]).to include("must be after clock_in_time")
    end

    it 'is valid if clock_out_time is after clock_in_time' do
      subject.clock_in_time = Time.current
      subject.clock_out_time = Time.current + 1.hour
      expect(subject).to be_valid
    end

    it 'is not valid if sleep! is called more than once without wake_up!' do
      subject.sleep!(Time.current)
      subject.sleep!(Time.current + 1.hour)
      expect(subject).to_not be_valid
      expect(subject.errors[:clock_in_time]).to include("already sleeping at #{subject.clock_in_time_was}")
    end

    it 'is not valid if wake_up! is called without sleep!' do
      subject.clock_out_time = Time.current
      expect(subject).to_not be_valid
      expect(subject.errors[:clock_out_time]).to include("clock_in_time is blank")
    end
  end

  describe 'callbacks' do
    let(:user) { User.create(name: "John Doe") }

    context 'creates a sleep_record after saving when both clock_in_time and clock_out_time are present' do
      it '' do
        user.sleep!(Time.now)
        user.wake_up!(Time.now + 1.hour)

        expect(user.sleep_records.count).to eq(1)
        expect(user.clock_in_time).to be_nil
        expect(user.clock_out_time).to be_nil
      end
    end
  end

  describe '#sleep!' do
    let(:user) { User.create(name: "John Doe") }

    it 'sets the clock_in_time to the current time' do
      freeze_time
      current_time = Time.current
      user.sleep!(current_time)
      expect(user.clock_in_time).to eq(current_time)
    end
  end

  describe '#wake_up!' do
    let(:user) { User.create(name: "John Doe", clock_in_time: Time.current) }

    it 'sets the clock_out_time to nil' do
      freeze_time
      current_time = Time.current
      user.wake_up!(current_time)
      expect(user.clock_out_time).to eq(nil)
    end
  end

  describe '#reset!' do
    let(:user) { User.create(name: "John Doe", clock_in_time: Time.current, clock_out_time: Time.current) }

    it 'resets clock_in_time and clock_out_time to nil' do
      user.reset!
      expect(user.clock_in_time).to be_nil
      expect(user.clock_out_time).to be_nil
    end
  end
end
