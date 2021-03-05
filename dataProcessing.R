# Clears all variables - the reset button
rm(list = ls())

library(tidyverse)
library(haven)

# Read in the STATA file
raw <- as_tibble(as_factor(read_dta("Data/Raw/Database_RICE.dta"))) %>% 
  mutate(across(where(is.factor), as.character))

cleaned <- raw %>% 
  select(-INTNR:-STIME) %>% 
  rename(interview_time = V6001) %>% 
  rename(age = V101) %>% 
  rename(age_bins = V102) %>% 
  rename(sex = V103) %>% 
  rename(marital_status = V104) %>% 
  rename(employment = V105) %>% 
  mutate(employment = na_if(employment, "No answer")) %>% 
  mutate(unemployed = as.numeric(employment == "Unemployed")) %>% 
  rename(income = V106) %>% 
  mutate(income = recode(income, "DON’T KNOW" = NA_character_, "REFUSED" = NA_character_)) %>% 
  rename(education = V107) %>% 
  rename(city = V108) %>% 
  rename(metroCategory = V109) %>% 
  mutate(islamist_v19 = as.numeric(V19 == "Islamist")) %>% 
  mutate(conservative_v19 = as.numeric(V19 == "Conservative")) %>% 
  mutate(nationalist_v19 = as.numeric(V19 == "Nationalist")) %>% 
  mutate(islamist_v25 = case_when(
    V25 == "Support" ~ 1,
    V25 == "Strongly support" ~ 1,
    V25 == "Don’t know" ~ NA_real_,
    TRUE ~ 0
  )) %>% 
  mutate(islamist_v27 = case_when(
    V27 == "Moderate influence" ~ 1,
    V27 == "Major influence" ~ 1,
    V27 == "Don’t know" ~ NA_real_,
    TRUE ~ 0
  )) %>% 
  mutate(democrat_v24 = case_when(
    V24 == "Agree" ~ 1,
    V24 == "Strongly Agree" ~ 1,
    V24 == "Don’t know" ~ NA_real_,
    TRUE ~ 0
  )) %>% 
  mutate(democrat_v24_numeric = case_when(
    V24 == "Strongly Agree" ~ 5,
    V24 == "Agree" ~ 4,
    V24 == "Neither agree or disagree" ~ 3,
    V24 == "Disagree" ~ 2,
    V24 == "Strongly disagree" ~ 1,
    TRUE ~ NA_real_
  )) %>%
  mutate(antiAmerican_v26 = case_when(
    V26 == "Strongly disapprove" ~ 1,
    V26 == "Disapprove" ~ 1,
    V26 == "Don’t know" ~ NA_real_,
    TRUE ~ 0
  )) %>% 
  mutate(islamist_v15 = as.numeric(V15 == "There is only one, true understanding of Shariah")) %>% 
  mutate(across(c(V1_1, V1_2, V1_5, V2_1, V2_2, V2_4), ~as.numeric(.x == "Yes"))) %>% 
  mutate(across(c(V1_3, V1_4, V2_3, V2_5, V2_6), ~as.numeric(.x == "No"))) %>% 
  mutate(across(starts_with("V1_"), ~ifelse(V1_6 == "Yes", 0, .x))) %>% 
  mutate(across(starts_with("V2_"), ~ifelse(V2_7 == "Yes", 0, .x))) %>% 
  select(-V1_6, -V2_7) %>% 
  mutate(fivePil = rowSums(across(starts_with("V1_")))) %>% 
  mutate(sixPil = rowSums(across(starts_with("V2_")))) %>% 
  mutate(fivePil = fivePil * 10/5) %>% 
  mutate(sixPil = sixPil * 10/6) %>% 
  mutate(religious_knowledge = fivePil + sixPil) %>% 
  mutate(salah = recode(V8, 
                        "Daily prayers every day" = 5, 
                        "A few times a week" = 4, 
                        "Once a week for Jummah prayer" = 3, 
                        "A few times a year, especially Eid prayers" = 2, 
                        "Never" = 1)) %>% 
  mutate(mosque_salah_attendance = recode(V9, 
                                          "More than once a week" = 6, 
                                          "Once a week for Jummah prayer" = 5, 
                                          "2- 3 times a month" = 4,
                                          "Once a month" = 3,
                                          "A few times a year, especially for the Eid" = 2,
                                          "Never" = 1)) %>% 
  mutate(quran = recode(V10,
                        "Every day" = 7,
                        "4 to 6 times a week" = 6,
                        "2 to 3 times a week" = 5,
                        "Once a week" = 4,
                        "Once or twice a month" = 3,
                        "A few times a year" = 2,
                        "Never" = 1)) %>% 
  mutate(salah = salah * 10/5) %>% 
  mutate(mosque_salah_attendance = mosque_salah_attendance * 10/6) %>% 
  mutate(quran = quran * 10/7) %>% 
  mutate(religious_behaving = salah + mosque_salah_attendance + quran) %>% 
  mutate(religious_behaving_2 = salah + quran) %>% 
  mutate(religious_importance = recode(V13,
                                       "Neutral" = 3,
                                       "Not at all important" = 1,
                                       "Not too important" = 2,
                                       "Somewhat important" = 4,
                                       "Very important" = 5,
                                       .default=NA_real_
                                       )) %>% 
  mutate(religion_eternal_life = recode(V14_1,
                                        "Strongly disagree" = 1,
                                        "Disagree" = 2,
                                        "Neither agree nor disagree" = 3,
                                        "Agree" = 4,
                                        "Strongly Agree" = 5,
                                        .default=NA_real_
                                        )) %>% 
  mutate(religion_one_interpretation = recode(V14_2,
                                              "Strongly disagree" = 1,
                                              "Disagree" = 2,
                                              "Neither agree nor disagree" = 3,
                                              "Agree" = 4,
                                              "Strongly Agree" = 5,
                                              .default=NA_real_
  )) %>% 
  mutate(religious_believing = religious_importance + religion_eternal_life + religion_one_interpretation) %>% 
  mutate(religious_belonging = as.numeric(V7 == "Islam - Sunni")) %>% 
  mutate(gov_performance = recode(V18,
                                  "Poor" = 1, 
                                  "Fair" = 2,
                                  "Good" = 3,
                                  "Very Good" = 4,
                                  "Excellent" = 5,
                                  .default=NA_real_
                                  )) %>% 
  mutate(corruption = recode(V17,
                             "Not a concern at all" = 1,
                             "A slight concern" = 2,
                             "Somewhat a concern" = 3,
                             "Moderate concern" = 4,
                             "Very serious concern" = 5,
                             .default=NA_real_
                             )) %>% 
  mutate(democracy = recode(V24,
                            "Strongly disagree" = 1,
                            "Disagree" = 2,
                            "Neither agree nor disagree" = 3,
                            "Agree" = 4,
                            "Strongly Agree" = 5,
                            .default=NA_real_
                            )) %>% 
  mutate(gender_views = recode(V28,
                               "Strongly disagree" = 1,
                               "Disagree" = 2,
                               "Neither agree nor disagree" = 3,
                               "Agree" = 4,
                               "Strongly Agree" = 5,
                               .default=NA_real_
  )) %>% 
  mutate(american_intervention = recode(V26,
                                        "Strongly disapprove" = 1,
                                        "Disapprove" = 2,
                                        "Neither approve nor disapprove" = 3,
                                        "Approve" = 4,
                                        "Strongly approve" = 5,
                                        .default=NA_real_
  )) %>% 
  mutate(shariah_implementation = recode(V25,
                                         "Strongly oppose" = 1,
                                         "Oppose" = 2,
                                         "Neutral" = 3,
                                         "Support" = 4,
                                         "Strongly support" = 5,
                                         .default=NA_real_
  )) %>% 
  mutate(religous_leaders_influence = recode(V27,
                                             "No influence" = 1,
                                             "Minor influence" = 2,
                                             "Neutral" = 3,
                                             "Moderate influence" = 4,
                                             "Major influence" = 5,
                                             .default=NA_real_
  )) %>% 
  mutate(suicide_bombing = recode(V29,
                                  "Never justified" = 1,
                                  "Almost never justified" = 2,
                                  "Occasionally justified" = 3,
                                  "Often justified" = 4,
                                  "Always justified" = 5,
                                  .default=NA_real_
  )) %>% 
  mutate(prime = V521) %>% 
  mutate(press_freedom = recode(V20_1,
                                "Not justified at all" = 5,
                                "Somewhat justified" = 4,
                                "Neither justified nor justified" = 3,
                                "Justified" = 2,
                                "Completely justified" = 1,
                                "Don't know" = NA_real_
                                )) %>% 
  mutate(imprison_journalists = recode(V20_2,
                                       "Not justified at all" = 5,
                                       "Somewhat justified" = 4,
                                       "Neither justified nor justified" = 3,
                                       "Justified" = 2,
                                       "Completely justified" = 1,
                                       "Don't know" = NA_real_
  )) %>% 
  mutate(internet_freedom = recode(V20_3,
                                   "Not justified at all" = 5,
                                   "Somewhat justified" = 4,
                                   "Neither justified nor justified" = 3,
                                   "Justified" = 2,
                                   "Completely justified" = 1,
                                   "Don't know" = NA_real_
  )) %>% 
  mutate(jail_opposition = recode(V20_4,
                                  "Not justified at all" = 5,
                                  "Somewhat justified" = 4,
                                  "Neither justified nor justified" = 3,
                                  "Justified" = 2,
                                  "Completely justified" = 1,
                                  "Don't know" = NA_real_
  )) %>% 
  mutate(imprison_civilians = recode(V20_5,
                                     "Not justified at all" = 5,
                                     "Somewhat justified" = 4,
                                     "Neither justified nor justified" = 3,
                                     "Justified" = 2,
                                     "Completely justified" = 1,
                                     "Don't know" = NA_real_
  )) %>% 
  mutate(dismiss_civilians = recode(V20_6,
                                    "Not justified at all" = 5,
                                    "Somewhat justified" = 4,
                                    "Neither justified nor justified" = 3,
                                    "Justified" = 2,
                                    "Completely justified" = 1,
                                    "Don't know" = NA_real_
  )) %>% 
  mutate(dismiss_generals = recode(V20_7,
                                   "Not justified at all" = 5,
                                   "Somewhat justified" = 4,
                                   "Neither justified nor justified" = 3,
                                   "Justified" = 2,
                                   "Completely justified" = 1,
                                   "Don't know" = NA_real_
  )) %>% 
  mutate(dismiss_judges = recode(V20_8,
                                 "Not justified at all" = 5,
                                 "Somewhat justified" = 4,
                                 "Neither justified nor justified" = 3,
                                 "Justified" = 2,
                                 "Completely justified" = 1,
                                 "Don't know" = NA_real_
  )) %>% 
  mutate(dismiss_academics = recode(V20_9,
                                    "Not justified at all" = 5,
                                    "Somewhat justified" = 4,
                                    "Neither justified nor justified" = 3,
                                    "Justified" = 2,
                                    "Completely justified" = 1,
                                    "Don't know" = NA_real_
  )) %>% 
  mutate(change_system = recode(V20_10,
                                "Not justified at all" = 5,
                                "Somewhat justified" = 4,
                                "Neither justified nor justified" = 3,
                                "Justified" = 2,
                                "Completely justified" = 1,
                                "Don't know" = NA_real_
  )) %>% 
  mutate(index_unscaled = rowSums(across(press_freedom:change_system))) %>% 
  mutate(across(press_freedom:change_system, ~ scales::rescale(.x, to=c(0,1)))) %>% 
  mutate(index_scaled = rowSums(across(press_freedom:change_system))) %>% 
  mutate(trust_erdogan = case_when(
    V162_2 == "Do not trust at all" ~ 1,
    V162_2 == "Only a little" ~ 2,
    V162_2 == "Indifferent" ~ 3,
    V162_2 == "Trust it somewhat" ~ 4,
    V162_2 == "Completely trust" ~ 5,
    V161_6 == "Do not trust at all" ~ 1,
    V161_6 == "Only a little" ~ 2,
    V161_6 == "Indifferent" ~ 3,
    V161_6 == "Trust it somewhat" ~ 4,
    V161_6 == "Completely trust" ~ 5,
    TRUE ~ NA_real_
  )) %>% 
  mutate(trust_ghannouchi = case_when(
    V162_1 == "Do not trust at all" ~ 1,
    V162_1 == "Only a little" ~ 2,
    V162_1 == "Indifferent" ~ 3,
    V162_1 == "Trust it somewhat" ~ 4,
    V162_1 == "Completely trust" ~ 5,
    V161_5 == "Do not trust at all" ~ 1,
    V161_5 == "Only a little" ~ 2,
    V161_5 == "Indifferent" ~ 3,
    V161_5 == "Trust it somewhat" ~ 4,
    V161_5 == "Completely trust" ~ 5,
    TRUE ~ NA_real_
  )) %>%
  mutate(trust_iyadh = case_when(
    V161_8 == "Do not trust at all" ~ 1,
    V161_8 == "Only a little" ~ 2,
    V161_8 == "Indifferent" ~ 3,
    V161_8 == "Trust it somewhat" ~ 4,
    V161_8 == "Completely trust" ~ 5,
    V162_9 == "Do not trust at all" ~ 1,
    V162_9 == "Only a little" ~ 2,
    V162_9 == "Indifferent" ~ 3,
    V162_9 == "Trust it somewhat" ~ 4,
    V162_9 == "Completely trust" ~ 5,
    TRUE ~ NA_real_
  )) %>%
  mutate(trust_nasrallah = case_when(
    V162_5 == "Do not trust at all" ~ 1,
    V162_5 == "Only a little" ~ 2,
    V162_5 == "Indifferent" ~ 3,
    V162_5 == "Trust it somewhat" ~ 4,
    V162_5 == "Completely trust" ~ 5,
    V161_2 == "Do not trust at all" ~ 1,
    V161_2 == "Only a little" ~ 2,
    V161_2 == "Indifferent" ~ 3,
    V161_2 == "Trust it somewhat" ~ 4,
    V161_2 == "Completely trust" ~ 5,
    TRUE ~ NA_real_
  )) %>%
  mutate(trust_ellouze = case_when(
    V162_13 == "Do not trust at all" ~ 1,
    V162_13 == "Only a little" ~ 2,
    V162_13 == "Indifferent" ~ 3,
    V162_13 == "Trust it somewhat" ~ 4,
    V162_13 == "Completely trust" ~ 5,
    V161_12 == "Do not trust at all" ~ 1,
    V161_12 == "Only a little" ~ 2,
    V161_12 == "Indifferent" ~ 3,
    V161_12 == "Trust it somewhat" ~ 4,
    V161_12 == "Completely trust" ~ 5,
    TRUE ~ NA_real_
  )) %>%
  mutate(trust_baghdadi = case_when(
    V162_6 == "Do not trust at all" ~ 1,
    V162_6 == "Only a little" ~ 2,
    V162_6 == "Indifferent" ~ 3,
    V162_6 == "Trust it somewhat" ~ 4,
    V162_6 == "Completely trust" ~ 5,
    V161_12 == "Do not trust at all" ~ 1,
    V161_12 == "Only a little" ~ 2,
    V161_12 == "Indifferent" ~ 3,
    V161_12 == "Trust it somewhat" ~ 4,
    V161_12 == "Completely trust" ~ 5,
    TRUE ~ NA_real_
  )) %>%
  mutate(across(starts_with("V121_"), replace_na, "NA")) %>% 
  mutate(approval_erdogan = as.numeric(V121_6 == "Yes" | V122_2 == "Yes")) %>%
  mutate(approval_ghannouchi = as.numeric(V121_5 == "Yes" | V122_1 == "Yes")) %>%
  mutate(approval_iyadh = as.numeric(V121_8 == "Yes" | V122_9 == "Yes")) %>%
  mutate(approval_nasrallah = as.numeric(V121_2 == "Yes" | V122_5 == "Yes")) %>%
  mutate(approval_ellouze = as.numeric(V121_12 == "Yes" | V122_13 == "Yes")) %>%
  mutate(approval_baghdadi = as.numeric(V122_6 == "Yes")) %>% 
  mutate(left_v19 = case_when(
    V19 == "Liberal" ~ 1,
    V19 == "Arab socialist" ~ 1,
    V19 == "Socialist" ~ 1,
    V19 == "Social democrat" ~ 1,
    TRUE ~ 0
  )) %>% 
  mutate(ennahada_V6_3 = case_when(
    V6_3 == "Don't Know" ~ NA_real_,
    V6_3 == "Refuse to answer" ~ NA_real_,
    V6_3 == "Do not agree at all" ~ 1,
    V6_3 == "Do not agree" ~ 2,
    V6_3 == "Agree" ~ 3,
    V6_3 == "Agree completely" ~ 4
  ))

cleaned %>% 
  select(-starts_with("V"), -starts_with("TV")) %>% 
  write_csv("Data/Raw/Tunisia_Processed.csv")
         