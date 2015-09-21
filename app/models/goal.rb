# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  user_id    :integer          not null
#  text       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  completed  :boolean          default(FALSE)
#  personal   :boolean          default(FALSE)
#

class Goal < ActiveRecord::Base
  validates :user_id, :title, :text, presence: true
  
  belongs_to :user

end
