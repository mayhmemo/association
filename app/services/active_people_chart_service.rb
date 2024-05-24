class ActivePeopleChartService
  def call
    {
      active: active_people_count(true),
      inactive: active_people_count(false)
    }
  end

  private

  def active_people_count(active)
    Person.where(active: active).count
  end
end