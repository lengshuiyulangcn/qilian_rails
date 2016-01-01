module JobSearch
  class Job < Grape::API
    format :json
    formatter :json, Grape::Formatter::Jbuilder

    get "/job_labels", jbuilder: 'job_labels' do
      @graduate_year = Label.by_graduate_year
      @category = Label.by_category
      @industry = Label.by_industry
    end
  end
end
