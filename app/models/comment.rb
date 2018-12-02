class Comment < ApplicationRecord
  validates :commenter, presence: true
  validates :body, presence: true, length: { in: 6...500 }
  belongs_to :article
end
