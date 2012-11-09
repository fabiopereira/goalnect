class RedemptionPointTransaction < ActiveRecord::Base
  attr_accessible :cpf, :money_amount, :point_amount, :user_id
end
