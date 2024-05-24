class MyPeopleService
  def initialize(user)
    @user = user
  end

  def call
    Person.where(user: @user).order(:created_at).limit(10)
  end
end