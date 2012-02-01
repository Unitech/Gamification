class WalletOperation < ActiveRecord::Base
  belongs_to :user
  # scope :euros, where("euros > 0").sum(:euros)
  # scope :epices, where("epices > 0").sum(:epices)
  # scope :points, where("points > 0").sum(:points)
  
  class Status < ReferenceData
    CREDIT = 0
    WITHDRAW = 1
  end

  def self.credit_user user, mission
    create :user => user, 
           :euros => mission.euros,
           :epices => mission.epices,
           :points => mission.points,
           :historic_type => WalletOperation::Status::CREDIT
    user.cash += mission.euros
    user.epices += mission.epices
    user.points += mission.points
    user.save
  end

  def self.withdraw_user user, mission
    create :user => user, 
           :euros => mission.euros,
           :epices => mission.epices,
           :points => mission.points,
           :historic_type => WalletOperation::Status::WITHDRAW
    user.cash -= mission.euros
    user.epices -= mission.epices
    user.points -= mission.points
    user.save
  end

  def self.euros_total_on date
    where("date(created_at) = ?", date).sum(:euros)
  end

  def self.epices_total_on date
    where("date(created_at) = ?", date).sum(:epices)
  end

  def self.points_total_on date
    where("date(created_at) = ?", date).sum(:points)
  end



  def contextualize_type
    if self.historic_type == WalletOperation::Status::CREDIT
      return "Credit"
    else self.historic_type == WalletOperation::Status::WITHDRAW
      return "Retrait"
    end
  end
end
