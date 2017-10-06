class SessionsController < ApplicationController
  def index
    @sessions = Session.all
    @abnormal = calc_abnormal
  end
end

private

def calc_abnormal
  total = @sessions.group_and_count_per_day
  failed = @sessions.failed.group_and_count_per_day
  abnormal = {}
  total.each do |k,v|
    unless total[k] == 0
      temp=((failed[k].to_f/total[k])*100).round(2)
      abnormal[k]=temp
    end
  end

  abnormal
end
