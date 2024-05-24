class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @active_people_pie_chart = Rails.cache.fetch('active_people_pie_chart', expires_in: 1.hour) do
      ActivePeopleChartService.new.call
    end

    @total_debts, @total_payments, @balance = Rails.cache.fetch('balance_data', expires_in: 1.hour) do
      BalanceCalculationService.new.call
    end

    @last_debts = Rails.cache.fetch('last_debts', expires_in: 1.hour) do
      LastDebtsService.new.call
    end

    @last_payments = Rails.cache.fetch('last_payments', expires_in: 1.hour) do
      LastPaymentsService.new.call
    end

    @my_people = Rails.cache.fetch('my_people', expires_in: 1.hour) do
      MyPeopleService.new(current_user).call
    end

    @top_person = Rails.cache.fetch('top_person', expires_in: 1.hour) do
      TopPersonService.new.call
    end

    @bottom_person = Rails.cache.fetch('bottom_person', expires_in: 1.hour) do
      BottomPersonService.new.call
    end
  end
end