################################################################################
#                 DIABETES & HYPERTENSION - AGE ABOVE 18
################################################################################

# load dataset
load(over18yrs)
View(over18yrs)

# Diabetes
summary(is.na(over18yrs$fasting_blood_glucose_mg_dl)) # 34274 NA's

ifelse(over18yrs$fasting_blood_glucose_mg_dl>=110,"Diabetic","Non-Diabetic")
over18yrs$diab <- ifelse(over18yrs$fasting_blood_glucose_mg_dl>=110,"Diabetic","Non-Diabetic")
over18yrs$diab <- factor(over18yrs$diab)
summary(over18yrs$diab)


#########################################################
#             Hypertension
#--------------------------------------------------------

# explore NA's
dim(over18yrs[over18yrs$BP_systolic=="NA" & over18yrs$BP_Diastolic!="NA",])
dim(over18yrs[over18yrs$BP_systolic!="NA" & over18yrs$BP_Diastolic=="NA",])
dim(over18yrs[over18yrs$BP_systolic!="NA" & over18yrs$BP_Diastolic!="NA",])
dim(over18yrs[over18yrs$BP_systolic=="NA" & over18yrs$BP_Diastolic=="NA",])

# average both systolic readings & both diastolic readings
over18yrs$systolic <- (over18yrs$BP_systolic + over18yrs$BP_systolic_2_reading)/2
over18yrs$diastolic <- (over18yrs$BP_Diastolic + over18yrs$BP_Diastolic_2reading)/2

# hypertension
over18yrs$htn <- ifelse(over18yrs$systolic >= 140 | over18yrs$diastolic >= 90, "Hypertensive", "Non-Hypertensive")

# frank, systolic & diastolic HTN
# >140 & >90
over18yrs$htn_type <- ifelse(over18yrs$systolic >= 140 & over18yrs$diastolic >= 90,"Frank Hypertension",
                        ifelse(over18yrs$systolic >= 140 & over18yrs$diastolic < 90, "Isolated Systolic Hypertension",
                          ifelse(over18yrs$systolic < 140 & over18yrs$diastolic >= 90, "Isolated Diastolic Hypertension","") ) )


over18yrs[over18yrs$systolic >= 140 & over18yrs$diastolic >= 90,]


# discard NA's

summary(is.na(over18yrs$fasting_blood_glucose_mg_dl)) # 34274 NA's