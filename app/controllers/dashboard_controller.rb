class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @active_people_pie_chart = ActivePeopleChartService.new.call
    @total_debts, @total_payments, @balance = BalanceCalculationService.new.call
    @last_debts = LastDebtsService.new.call
    @last_payments = LastPaymentsService.new.call
    @my_people = MyPeopleService.new(current_user).call
    @top_person = TopPersonService.new.call
    @bottom_person = BottomPersonService.new.call
  end
end