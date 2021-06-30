library(tidyverse)
library(gmapsdistance)

set.api.key(Sys.getenv("key"))

origin <- str_replace_all(Sys.getenv("start1")," ", "+")
destination <- str_replace_all(Sys.getenv("end1")," ", "+")

results <- 
  gmapsdistance(origin = origin, destination = destination,
              mode = "driving", shape = "wide")

tibble(origin = str_replace_all(origin,"\\+"," "), 
       destination = str_replace_all(destination, "\\+"," "), 
       time = results$Time/60, 
       distance = results$Distance/1609.34,
       search_time = lubridate::now()
       )

