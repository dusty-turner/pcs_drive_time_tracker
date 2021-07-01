library(tidyverse)
library(gmapsdistance)
source("/home/ubuntu/Projects/pcs_drive_time_tracker/source_files/drive_time_source.R")

set.api.key(key = key)

map_once <- function(start = start1, end = end1){

origin <- str_replace_all(start," ", "+")
destination <- str_replace_all(end," ", "+")

results <- 
  gmapsdistance(origin = origin, destination = destination,mode = "driving", shape = "wide")

new_results <-
tibble(origin = str_replace_all(origin,"\\+"," "), 
       destination = str_replace_all(destination, "\\+"," "), 
       time = results$Time/60, 
       distance = results$Distance/1609.34,
       search_time = lubridate::now()
       )

return(new_results)

}

new_results <-
map2_dfr(.x = list_start, .y = list_end, .f = ~map_once(start = .x,end = .y))

old_results <- read_csv("/home/ubuntu/Projects/pcs_drive_time_tracker/results/results.csv")

old_results %>% 
  bind_rows(new_results) %>% 
  distinct() %>% 
  write_csv("/home/ubuntu/Projects/pcs_drive_time_tracker/results/results.csv")


rmarkdown::render("/home/ubuntu/Projects/pcs_drive_time_tracker/publish/Publish_script.Rmd")

system("git status")
system("git pull")
system("git add .")
system(str_c("git commit -m \"commit at ", lubridate::now(), "\""))
system("git push")
