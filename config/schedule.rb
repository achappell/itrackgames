set :job_template, "/bin/bash -l -c 'cmd.exe /C \":job\"'"

job_type :win_rake, "cd :path && set RAILS_ENV=:environment rake :task --silent :output"
job_type :pg_dump, "cd :path && set RAILS_ENV=:environment rake :task --silent :output"

every 1.day, :at => '4:30 am' do
  win_rake "importAllData"
end
