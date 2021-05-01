module ApplicationHelper
  def clock_btn_class(event)
    event.clocked_in? ? "btn btn-success" : "btn btn-danger"
  end
end
