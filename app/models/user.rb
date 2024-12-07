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
end
