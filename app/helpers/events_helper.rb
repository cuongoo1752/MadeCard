module EventsHelper
  def name_button_category event
    categories = Category.where(status: 1, event_id: event.id)
    categories_id = categories.pluck(:id)
    wishes = Wish.where(status: 1, category_id: categories_id)
    "Chi tiết #{categories.size} đề mục, #{wishes.size} lời chúc"
  end
end
