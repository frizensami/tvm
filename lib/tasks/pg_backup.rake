namespace :db do
	task :pg_backup do
		puts "Beginning DB backup"
		sh "pg_dump --username root tvm_production > /home/rails/rails_project/db/backup/#{Time.now.to_formatted_s(:number)}"
		puts "Backup complete"
	end
end
