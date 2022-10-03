class Task < ApplicationRecord

    belongs_to :user

    has_and_belongs_to_many :categories

    enum status: { not_started: 0, in_progress: 1,  finished: 2 }

    def self.search(search_params)
        tasks = Task.all
        tasks = tasks.where!(status: search_params[:status]) if search_params[:status].present?
        tasks = tasks.where!('register_at >= ?', search_params[:start_date_beginning].to_date.beginning_of_day) if search_params[:start_date_beginning].present?
        tasks = tasks.where!('register_at <= ?', search_params[:end_date_beginning].to_date.end_of_day) if search_params[:end_date_beginning].present?
        tasks = tasks.where!('concluded_at >= ?', search_params[:start_date_conclusion].to_date.beginning_of_day) if search_params[:start_date_conclusion].present?
        tasks = tasks.where!('concluded_at <= ?', search_params[:end_date_conclusion].to_date.end_of_day) if search_params[:end_date_conclusion].present?
        tasks
    end

end
