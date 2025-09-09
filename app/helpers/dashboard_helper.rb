module DashboardHelper
  def calculate_bar_height(value, total)
    return 0 if total.zero?
    [ (value.to_f / total * 100).round(1), 100 ].min
  end
end
