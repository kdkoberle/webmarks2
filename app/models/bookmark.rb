# == Schema Information
#
# Table name: bookmarks
#
#  id         :integer          not null, primary key
#  username   :string(255)
#  name       :string(255)
#  url        :string(255)
#  date_saved :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Bookmark < ActiveRecord::Base
  attr_accessible :date_saved, :name, :url, :username
  
  belongs_to :user
  #before_save :assign_username
  
  validates :url, :length => { :minimum => 10 }
  validates :name, :length => { :maximum => 99 }
  validates :name, :length => { :minimum => 1 }
  
  def assign_username
    self.username = User.find_by_username(params[:session][:username].downcase)
  end
  
end
