namespace :db do
  namespace :production do
    desc "backup the production database to local file"
    task :backup do | t |
      file_name = "#{Time.now.strftime("%Y-%m-%d-%H-%M-%S")}-backup.sql"
      puts "Backing up the production database to: #{file_name}"
      `mysqldump -u cfv2a -p -h mysql.confreaks.net cfv2a > #{file_name}`
      puts "Backup completed."
    end
  end
end
