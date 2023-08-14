library(tidyverse)
library(gtsummary)

tbl_summary(
	nlsy,
	by = sex_cat,
	include = c(race_eth_cat, region_cat, income,
							sleep_wkdy, sleep_wknd), #can also use starts_with("sleep")
	label = list(
		race_eth_cat ~ "Race/ethnicity",
		region_cat ~ "Region",
		income ~ "Income",
		sleep_wkdy ~ "Weekday sleep",
		sleep_wknd ~ "Weekend sleep"
	),
	statistic = list(
		income ~ "10th = {p10}, 90th = {p90}",
		starts_with("sleep") ~ "min = {min}, max = {max}"
	),
	digits = list(
		income ~ c(3,3),
		starts_with("sleep") ~ c(1,1)
	),
	missing_text = "Missing") %>%
	add_p(test = list(all_continuous() ~ "t.test",
										all_categorical() ~ "chisq.test"))|>
	add_overall(col_label = "**Total**")
