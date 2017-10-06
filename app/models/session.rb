class Session < ActiveRecord::Base
  scope :failed, -> { where.not(summary_status: 'passed') }
  scope :group_and_count_per_day, -> { group_by_day(:created_at, format: "%B %d, %Y").count }
end
