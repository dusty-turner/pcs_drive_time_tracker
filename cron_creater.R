library(cronR)

cron_ls()
cron_clear(ask=FALSE)

f <- system.file(normalizePath("start_of_google_api_work.R"))
cmd <- cron_rscript(normalizePath("start_of_google_api_work.R"), workdir = "/home/ubuntu/Projects/pcs_drive_time_tracker/")
# cmd <- cron_rscript(normalizePath("start_of_google_api_work.R"), workdir = normalizePath("~"))
cmd

cron_add(command = cmd, 
         frequency = '0,30 0-5,9-15,18-23 * * *', 
         # frequency = '*/1 * * * *', 
         # frequency = '*/10 * * * *', 
         id = 'drive_time_getter_off_peak', 
         description = 'gets_multiple_drive_times_off_peak'
         )

cron_add(command = cmd, 
         frequency = '*/5 5-9,15-18 * * *', 
         # frequency = '*/1 * * * *', 
         # frequency = '*/10 * * * *', 
         id = 'drive_time_getter_peak', 
         description = 'gets_multiple_drive_times_peak', 
         tags = c('lab', 'xyz')
         )

cron_njobs()

cron_ls()
cron_clear(ask=FALSE)


# cron_ls()
# 
# cmd <- cron_rscript(f, rscript_args = c("productx", "arg2", "123"))
# cmd
# cron_add(cmd, frequency = 'minutely', id = 'job1', description = 'Customers')
# cron_add(cmd, frequency = 'hourly', id = 'job2', description = 'Weather')
# cron_add(cmd, frequency = 'hourly', id = 'job3', days_of_week = c(1, 2))
# cron_add(cmd, frequency = 'hourly', id = 'job4', at = '00:20', days_of_week = c(1, 2))
# cron_add(cmd, frequency = 'daily', id = 'job5', at = '14:20')
# cron_add(cmd, frequency = 'daily', id = 'job6', at = '14:20', days_of_week = c(0, 3, 5))
# cron_add(cmd, frequency = 'daily', id = 'job7', at = '23:59', days_of_month = c(1, 30))
# cron_add(cmd, frequency = 'monthly', id = 'job8', at = '10:30', 
#          days_of_month = 'first', days_of_week = '*')
# cron_add(cmd, frequency = '@reboot', id = 'job9', description = 'Good morning')
# cron_add(cmd, frequency = '*/15 * * * *', id = 'job10', description = 'Every 15 min')   
# cron_ls()
# cron_clear(ask=FALSE)
# 
# ## End(Not run)