class Session < ActiveRecord::Base
  scope :failed, -> { where.not(summary_status: 'passed') }

  class << self
    def group_and_count_per_day
      group_by_day(:created_at, format: "%B %d, %Y").count
    end

    def calc_abnormal
      total = group_and_count_per_day
      fail = failed.group_and_count_per_day
      abnormal = {}
      total.each do |k,v|
        unless total[k] == 0
          temp=((fail[k].to_f/total[k])*100).round(2)
          abnormal[k]=temp
        end
      end

      abnormal
    end
  end
end
