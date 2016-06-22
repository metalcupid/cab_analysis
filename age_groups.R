####### Load Dataset #################

#odisha <- read.csv("E:/CAB_Analysis/CAB_Analysis/data/Odisha/odisha.csv")
#odisha <- read.csv("E:/CAB_Analysis/CAB_Analysis/data/Odisha/odisha.csv")
odisha <- read.csv("F:/CAB_Analysis/CAB_Analysis/data/States/Odisha.csv")

View(odisha)
dim(odisha)
saveRDS(odisha, file="odisha.Rda")

#--------------------------------------

# Step 1

####### Cleaning Dataset #############


    # remove duplicates of headers due to cmd merging

    odisha <- odisha[odisha$Age_Code!="Age_Code",]
    dim(odisha)
    summary(odisha$Age_Code)

    odisha <- odisha[odisha$Age_Code!="vegetables_month_or_day",]
    dim(odisha)
    summary(odisha$Age_Code)

    # drop unused levels from Age_Code

    odisha <- droplevels.data.frame(odisha)
    summary(odisha$Age_Code)

#------------------------------------------------------------------------------
    
# Step 2
    
####### Creating Subsets #############

    # neonates in days
    
    neonates <- odisha[odisha$Age_Code=="Days",]
    dim(neonates)
    saveRDS(neonates, file="neonates.Rda")
    
    #--------------------------------------------------------------------------
    # infants in months
    
    infants <- odisha[odisha$Age_Code=="Months" | odisha$Age_Code=="Days",] 
    str(infants$Age)
    summary(infants$Age)
    dim(infants)
    saveRDS(infants, file="infants.Rda")
    
      # convert factor to number - Age
        #infants$Age <- as.numeric(levels(infants$Age)[infants$Age])
      
    #---------------------------------------------------------------------------
    # 1 month and above
    
    over1month <- odisha[odisha$Age_Code!="Days",]
    
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
    under3yrs1 <- odisha[odisha$Age_Code!="Days",] #Exclude neonates
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
    under5yrs1 <- odisha[odisha$Age_Code!="Days",] #Exclude neonates
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
    # 18 and above
    
    over18yrs <- odisha[odisha$Age>=18 & odisha$Age_Code=="Year",]
    dim(over18yrs)
    saveRDS(over18yrs, file="over18yrs.Rda")
    
    #---------------------------------------------------------------------------
    # Women 15-49 yrs
    
    women <- odisha[odisha$Sex=="Female",]
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
                      women
                      women_15to49yrs
                      over18yrs

#########################################################################
