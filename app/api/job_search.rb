module JobSearch
  class JobSearch < Grape::API
    format :json
    formatter :json, Grape::Formatter::Jbuilder

    get "/job_labels", jbuilder: 'job_labels' do
      @graduate_year = Label.by_graduate_year
      @category = Label.by_category
      @industry = Label.by_industry
    end

    desc "search jobs"
    params do
      requires :labels,     type: Array[Integer]
    end
    post "/job_search", jbuilder: "jobs" do
      labels = params[:labels]
      graduate_jobs = Job.all.category_select(labels,'gradyear')
      category_jobs =Job.all.category_select(labels,'genre')
      industry_jobs = Job.all.category_select(labels,'industry') 
      @jobs = graduate_jobs & category_jobs & industry_jobs
      @labels = Label.where(id: labels)
      @jobs = Job.where(id: @jobs.map{|job| job.id}, expire_at: Time.current..Time.current+1.year)  
    end
    desc "search jobs"
    params do
      requires :id, type: Integer
    end
    get "/job", jbuilder: "job" do
      @job = Job.find(params[:id])
    end
  end
end
