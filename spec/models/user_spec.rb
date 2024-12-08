require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include("can't be blank")
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
      expect(subject.errors[:clock_in_time]).to include("#{subject.name} already slept at #{subject.clock_in_time_was}")
    end

    it 'is not valid if wake_up! is called without sleep!' do
      subject.clock_out_time = Time.current
      expect(subject).to_not be_valid
      expect(subject.errors[:clock_out_time]).to include("#{subject.name} is awake")
    end
  end

  describe 'callbacks' do
    let(:user) { create(:user) }

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
    let(:user) { create(:user) }

    it 'sets the clock_in_time to the current time' do
      freeze_time
      current_time = Time.current
      user.sleep!(current_time)
      expect(user.clock_in_time).to eq(current_time)
    end
  end

  describe '#wake_up!' do
    let(:user) { create(:user, clock_in_time: Time.current) }

    it 'sets the clock_out_time to nil' do
      freeze_time
      current_time = Time.current
      user.wake_up!(current_time)
      expect(user.clock_out_time).to eq(nil)
    end
  end

  describe '#reset!' do
    let(:user) { create(:user, clock_in_time: Time.current, clock_out_time: Time.current) }

    it 'resets clock_in_time and clock_out_time to nil' do
      user.reset!
      expect(user.clock_in_time).to be_nil
      expect(user.clock_out_time).to be_nil
    end
  end

  describe 'follow/unfollow functionality' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    describe '#follow' do
      it 'allows a user to follow another user' do
        user.follow(other_user)
        expect(user.following).to include(other_user)
      end

      it 'does not allow a user to follow themselves' do
        user.follow(user)
        expect(user.following).to_not include(user)
      end

      it 'does not allow a user to follow the same user multiple times' do
        user.follow(other_user)
        user.follow(other_user) # Attempt to follow again
        expect(user.following.count).to eq(1)
      end
    end

    describe '#unfollow' do
      it 'allows a user to unfollow another user' do
        user.follow(other_user)
        user.unfollow(other_user)
        expect(user.following).to_not include(other_user)
      end

      it 'does not raise an error if unfollowing a user not followed' do
        expect { user.unfollow(other_user) }.to_not raise_error
      end
    end

    describe '#following?' do
      it 'returns true if the user is following another user' do
        user.follow(other_user)
        expect(user.following?(other_user)).to be_truthy
      end

      it 'returns false if the user is not following another user' do
        expect(user.following?(other_user)).to be_falsey
      end
    end
  end
end
