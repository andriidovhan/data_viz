require 'csv'

namespace :csv_import do
  desc "move csv data from file"
  task upload_data: :environment do
    csv_text = File.read("public/session_history.csv")
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    csv.each do |row|
      t = Session.new
      t.session_id = row['session_id']
      t.started_by = row['started_by']
      t.created_at = row['created_at']
      t.summary_status = row['summary_status']
      t.duration = row['duration'].to_f
      t.worker_time = row['worker_time']
      t.bundle_time = row['bundle_time']
      t.num_workers = row['num_workers']
      t.branch = row['branch']
      t.commit_id = row['commit_id']
      t.started_tests_count = row['started_tests_count']
      t.passed_tests_count = row['passed_tests_count']
      t.failed_tests_count = row['failed_tests_count']
      t.pending_tests_count = row['pending_tests_count']
      t.skipped_tests_count = row['skipped_tests_count']
      t.error_tests_count = row['error_tests_count']
      t.save
      puts "#{t.session_id} saved"
    end
  end

end
