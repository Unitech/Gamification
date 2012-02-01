module UserHelper
  
  def series from_date, field_name, data
    (from_date..Date.today).map { |date| 
      chart_series field_name, data, date
    }.inspect
  end

  def chart_series field, historic, date
    tmp = 0
    historic.each do |h|
      if h[field] > 0 and h[:created_at].to_date == date
        tmp += h[field]
      end
    end
    tmp
  end

  def actions_series from_date, data

    (from_date..Date.today).map { |date| 
      action_chart_series data, date
    }.inspect
  end

  def action_chart_series historic, date
    tmp = 0
    historic.each do |h|
      if h[:updated_at].to_date == date
        tmp += 1
      end
    end
    tmp
  end
  
  def orders_chart_series(orders, start_time)
    orders_by_day = orders.where(:purchased_at => start_time.beginning_of_day..Time.zone.now.end_of_day).
      group("date(purchased_at)").
      select("purchased_at, sum(total_price) as total_price")
    (start_time.to_date..Date.today).map do |date|
      order = orders_by_day.detect { |order| order.purchased_at.to_date == date }
      order && order.total_price.to_f || 0
    end.inspect
  end
end
