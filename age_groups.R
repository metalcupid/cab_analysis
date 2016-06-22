####### Load Dataset #################

#odisha <- read.csv("E:/CAB_Analysis/CAB_Analysis/data/Odisha/odisha.csv")
odisha <- read.csv("F:/CAB_Analysis/CAB_Analysis/data/States/Odisha.csv")

View(odisha)
dim(odisha)
saveRDS(odisha, file="odisha.Rda")

###########################################
#   rename dataframe as df
#--------------------------------------
df <- odisha
#--------------------------------------

# Step 1

####### Cleaning Dataset #############


    # remove duplicates of headers due to cmd merging

    df <- df[df$Age_Code!="Age_Code",]
    dim(df)
    summary(df$Age_Code)

    df <- df[df$Age_Code!="vegetables_month_or_day",]
    dim(df)
    summary(df$Age_Code)

    # drop unused levels from Age_Code

    df <- droplevels.data.frame(df)
    summary(df$Age_Code)

#------------------------------------------------------------------------------
    
# Step 2
    
####### Creating Subsets #############

    # neonates in days
    
    neonates <- df[df$Age_Code=="Days",]
    dim(neonates)
    saveRDS(neonates, file="neonates.Rda")
    
    #--------------------------------------------------------------------------
    # infants in months
    
    infants <- df[df$Age_Code=="Months" | df$Age_Code=="Days",] 
    str(infants$Age)
    summary(infants$Age)
    dim(infants)
    saveRDS(infants, file="infants.Rda")
    
      # convert factor to number - Age
        #infants$Age <- as.numeric(levels(infants$Age)[infants$Age])
      
    #---------------------------------------------------------------------------
    # 1 month and above
    
    over1month <- df[df$Age_Code!="Days",]
    
      # convert factor to number - Age
        #over1month$Age <- as.numeric(levels(over1month$Age)[over1month$Age])
    
    summary(over1month$Age)
    dim(over1month)
    saveRDS(over1month, file="over1month.Rda")
    
    #---------------------------------------------------------------------------
    # 6 months and above
    
    over6months1 <- over1month[over1month$Age>5 & over1month$Age_Code=="Months",]
    over6months2 <- over1month[over1month$Age_Code=="Year",]
    dim(over6months1)
    dim(over6months2)
    
    over6months  <- rbind(over6months1,over6months2)
    dim(over6months)
    saveRDS(over6months, file="over6months.Rda")
    
    rm(over6months1,over6months2)
    
    #---------------------------------------------------------------------------
    # Under 3 
    under3yrs1 <- df[df$Age_Code!="Days",] #Exclude neonates
    under3yrs2 <- under3yrs1[under3yrs1$Age<4 & under3yrs1$Age_Code=="Year",]
    under3yrs3 <- under3yrs1[under3yrs1$Age_Code=="Months",]
    under3yrs <- rbind(under3yrs2,under3yrs3)
    
    dim(under3yrs1)
    dim(under3yrs2)
    dim(under3yrs3)
    dim(under3yrs)
    saveRDS(under3yrs, file="under3yrs.Rda")
    
    rm(under3yrs1,under3yrs2,under3yrs3)
    
    
    #---------------------------------------------------------------------------
    # Under 5 
    under5yrs1 <- df[df$Age_Code!="Days",] #Exclude neonates
    under5yrs2 <- under5yrs1[under5yrs1$Age<6 & under5yrs1$Age_Code=="Year",]
    under5yrs3 <- under5yrs1[under5yrs1$Age_Code=="Months",]
    under5yrs <- rbind(under5yrs2,under5yrs3)
    
    dim(under5yrs1)
    dim(under5yrs2)
    dim(under5yrs3)
    dim(under5yrs)
    saveRDS(under5yrs, file="under5yrs.Rda")
    
    rm(under5yrs1,under5yrs2,under5yrs3)
    
    #---------------------------------------------------------------------------
    # 5 to 18 years
    between5to18yrs <- df[df$Age_Code=="Year",]
    dim(between5to18yrs)
    
    between5to18yrs <- between5to18yrs[between5to18yrs$Age>=5,]
    dim(between5to18yrs)
    
    between5to18yrs <- between5to18yrs[between5to18yrs$Age<=18,]
    dim(between5to18yrs)
    
    summary(between5to18yrs$Age)
    
    saveRDS(between5to18yrs, file="between5to18yrs.Rda")
    
    #---------------------------------------------------------------------------
    # 18 and above
    
    over18yrs <- df[df$Age>=18 & df$Age_Code=="Year",]
    dim(over18yrs)
    saveRDS(over18yrs, file="over18yrs.Rda")
    
    #---------------------------------------------------------------------------
    # Women 15-49 yrs
    
    women <- df[df$Sex=="Female",]
    saveRDS(women, file="women.Rda")
    women_15to49yrs <- women[women$Age>=15 & women$Age_Code=="Year",]
    dim(women_15to49yrs)
    saveRDS(women_15to49yrs, file="women_15to49yrs.Rda")
    
    
##########################################################################
                    #Age Groups

                      neonates    
                      infants
                      over1month
                      over6months
                      under3yrs
                      under5yrs 
                      between5to18yrs
                      women_15to49yrs
                      women
                      over18yrs
                      over60yrs # for BMI classification
                      
###########################################################################
                      # Age Groups for Anaemia according to India
                      
                      # 6 - 59 MONTHS
                      # 5 - 9 YEARS
                      # 10 - 17 YEARS
                      # 18 - 59 YEARS 
                      # 60 AND ABOVE                      

                      
df$ind_age_groups <-   ifelse(df$Age_Code=="Months" & df$Age>=6, "6 - 59 Months", 
                             ifelse(df$Age_Code=="Year" & df$Age<5, "6 - 59 Months",
                                ifelse(df$Age_Code=="Year" & df$Age>=5  & df$Age<10, "5 - 9 Years",
                                      ifelse(df$Age_Code=="Year" & df$Age>=10  & df$Age<18, "10 - 17 Years",
                                            ifelse(df$Age_Code=="Year" & df$Age>=18  & df$Age<60, "18 - 59 Years",
                                                  ifelse(df$Age_Code=="Year" & df$Age>=60 , "10 - 17 Years","Other" ) ) ) ) ) )                        
                      
df$ind_age_groups <- factor(df$ind_age_groups, levels = c("6 - 59 Months", "5 - 9 Years", "10 - 17 Years", "18 - 59 Years"))
summary(df$ind_age_groups)
View(df[df$ind_age_groups=="Other",])

#-------------------------------------------------------------------------------------------------------                      
# Age Groups for Anaemia according to WHO

# 6 - 59 MONTHS
# 5 - 11 YEARS
# 12 - 14 YEARS
# 14 AND ABOVE MALE
# 14 AND ABOVE FEMALE

df$who_age_groups <-   ifelse(df$Age_Code=="Months" & df$Age>=6, "6 - 59 Months", 
                                  ifelse(df$Age_Code=="Year" & df$Age<5, "6 - 59 Months",
                                         ifelse(df$Age_Code=="Year" & df$Age>=5  & df$Age<12, "5 - 11 Years",
                                                ifelse(df$Age_Code=="Year" & df$Age>=12  & df$Age<15, "12 - 14 Years",
                                                       ifelse(df$Age_Code=="Year" & df$Age>=14  & df$Sex=="Male", "Above 14 Years - Male",
                                                              ifelse(df$Age_Code=="Year" & df$Age>=14  & df$Sex=="Female", "Above 14 Years - Female","Other" ) ) ) ) ) )                        

df$who_age_groups <- factor(df$who_age_groups, levels = c("6 - 59 Months", "5 - 11 Years", "12 - 14 Years", "Above 14 Years - Female", "Above 14 Years - Male"))
summary(df$who_age_groups)
View(df[df$who_age_groups=="Other",])

#########################################################################
