namespace :events do
  desc "Rake task to remove qr images"
  task :fetch => :environment do
    FileUtils.rm_rf('assets/images/qrs')
  end
end