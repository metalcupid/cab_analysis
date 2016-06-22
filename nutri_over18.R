################################################################################
#  BMI                NUTRITIONAL STATUS - AGE ABOVE 18
################################################################################

#             CALCULATE BMI

# load dataset
load(over18yrs)
View(over18yrs)

# recode height in mtr
over18yrs$height_mtr <- over18yrs$Length_height_cm/100

# define bmi function
calc_bmi <- function(Weight_in_kg, height_mtr) {
  return(Weight_in_kg / (height_mtr * height_mtr))}


#calculate BMI
over18yrs$bmi <- calc_bmi(over18yrs$Weight_in_kg, over18yrs$height_mtr)



#categorize BMI 
  # Underweight = <18.5
  # Normal weight = 18.5-22.9 
  # Overweight = 23-24.9 
  # Obesity = BMI of 25 or greater

over18yrs$bmi_cat <-   ifelse(over18yrs$bmi !="NA" & over18yrs$bmi < 18.5, "Underweight",
                          ifelse(over18yrs$bmi !="NA" & over18yrs$bmi >= 18.5 & over18yrs$bmi < 23, "Normal weight",
                              ifelse(over18yrs$bmi !="NA" & over18yrs$bmi >= 23 & over18yrs$bmi < 25, "Overweight",
                                  ifelse(over18yrs$bmi !="NA", "Obese", "") ) ) )

over18yrs$bmi_cat <- factor(over18yrs$bmi_cat, levels = c("Underweight","Normal weight","Overweight","Obese"))
summary(over18yrs$bmi_cat)



# split dataset into 18-59 yrs and over 60 yrs
#----------------------------------------------------
# between18to59yrs  <- over18yrs[over18yrs$Age<60,]
# over60yrs         <- over18yrs[over18yrs$Age>=60,]


