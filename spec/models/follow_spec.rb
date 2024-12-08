# == Schema Information
#
# Table name: follows
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :integer
#  follower_id :integer
#
# Indexes
#
#  index_follows_on_followed_id                  (followed_id)
#  index_follows_on_follower_id                  (follower_id)
#  index_follows_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#
require 'rails_helper'

RSpec.describe Follow, type: :model do
  describe 'validations' do
    subject { build(:follow) }

    it 'is not valid without a follower_id' do
      subject.follower_id = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:follower_id]).to include("can't be blank")
    end

    it 'is not valid without a followed_id' do
      subject.followed_id = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:followed_id]).to include("can't be blank")
    end

    it 'is not valid if a user tries to follow themselves' do
      user = create(:user)
      subject.follower = user
      subject.followed = user
      expect(subject).to_not be_valid
      expect(subject.errors[:follower_id]).to include("can't follow themselves")
    end
  end
end
