##################################################################################
#     NUTRITIONAL STATUS BELOW 5 YEARS
##################################################################################
          # Wasting               -2 SD wt/ht
          # Stunting              -2 SD ht/age
          # Underweight           -2 SD wt/age
          # Undernourished        -2 SD BMI/age
          # Overnourished         +2 SD BMI/age
#--------------------------------------------------------------------------------

# Load Data

load(under5yrs)
View(under5yrs)

# Recode Age in Months
under5yrs$multiplication_factor<- ifelse(under5yrs$Age_Code=="Year",12,1)
as.factor(under5yrs$multiplication_factor)
under5yrs$Age_months <- under5yrs$Age * under5yrs$multiplication_factor
