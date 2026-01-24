class ConsultAssignment < ApplicationRecord
  belongs_to :user
  belongs_to :consult


   validates :user_id, uniqueness: { scope: :consult_id }
end
