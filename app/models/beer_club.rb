class BeerClub < ActiveRecord::Base
  attr_accessible :city, :founded, :name

  validates :name, :presence => :true



  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships


  def members
    memberships.where(:confirmed => true)
  end

  def pending
   return memberships.where(:confirmed => [false, nil])
  end

end

