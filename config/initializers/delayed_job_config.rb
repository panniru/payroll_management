Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.sleep_delay = 60
Delayed::Worker.max_attempts = 0
Delayed::Worker.destroy_failed_jobs = false
# Delayed::Worker.delay_jobs = !Rails.env.test?
Delayed::Worker.logger = Rails.logger
#Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'dj.log'), 10, 1024000)
#Delayed::Worker.logger.auto_flushing = 1
