require(ggplot2)
require(RColorBrewer)


setwd("~/Desktop")

first_try <- read.table("munged_buckets_sym.dat", h=T)
first_try <- read.table("munged_sym_spatial_buckets.dat", h=T)
first_try <- read.table("munged_host_spatial_buckets.dat", h=T)
first_try <- subset(first_try, treatment=="mut0.001_mult1_vert0.6_start0.")
first_try <- subset(first_try, rep=="1003")
first_try <- subset(first_try, update <= 10000)
first_try <- subset(first_try, treatment=="mut0.001_mult1_vert0.7_start0.")

neg1_9 <- cbind(subset(first_try, interval=="-1_-.9"), Interaction_Rate="-1 to -0.6 (Parasitic)")
neg9_8 <- cbind(subset(first_try, interval=="-.9_-.8"), Interaction_Rate="-1 to -0.6 (Parasitic)")
neg8_7 <- cbind(subset(first_try, interval=="-.8_-.7"), Interaction_Rate="-0.8 to -0.6 (Parasitic)")
neg7_6 <- cbind(subset(first_try, interval=="-.7_-.6"), Interaction_Rate="-0.8 to -0.6 (Parasitic)")
neg6_5 <- cbind(subset(first_try, interval=="-.6_-.5"), Interaction_Rate="-0.6 to -0.4 (Detrimental)")
neg5_4 <- cbind(subset(first_try, interval=="-.5_-.4"), Interaction_Rate="-0.6 to -0.4 (Detrimental)")
neg4_3 <- cbind(subset(first_try, interval=="-.4_-.3"), Interaction_Rate="-0.4 to -0.2 (Detrimental)")
neg3_2 <- cbind(subset(first_try, interval=="-.3_-.2"), Interaction_Rate="-0.4 to -0.2 (Detrimental)")
neg2_1 <- cbind(subset(first_try, interval=="-.2_-.1"), Interaction_Rate="-0.2 to 0 (Nearly Neutral)")
neg1_0 <- cbind(subset(first_try, interval=="-.1_0"), Interaction_Rate="-0.2 to 0 (Nearly Neutral)")
pos0_1 <- cbind(subset(first_try, interval=="0_.1"), Interaction_Rate="0 to 0.2 (Nearly Neutral)")
pos1_2 <- cbind(subset(first_try, interval==".1_.2"), Interaction_Rate="0 to 0.2 (Nearly Neutral)")
pos2_3 <- cbind(subset(first_try, interval==".2_.3"), Interaction_Rate="0.2 to 0.4 (Positive)")
pos3_4 <- cbind(subset(first_try, interval==".3_.4"), Interaction_Rate="0.2 to 0.4 (Positive)")
pos4_5 <- cbind(subset(first_try, interval==".4_.5"), Interaction_Rate="0.4 to 0.6 (Positive)")
pos5_6 <- cbind(subset(first_try, interval==".5_.6"), Interaction_Rate="0.4 to 0.6 (Positive)")
pos6_7 <- cbind(subset(first_try, interval==".6_.7"), Interaction_Rate="0.6 to 0.8 (Mutualistic)")
pos7_8 <- cbind(subset(first_try, interval==".7_.8"), Interaction_Rate="0.6 to 0.8 (Mutualistic)")
pos8_9 <- cbind(subset(first_try, interval==".8_.9"), Interaction_Rate="0.6 to 1.0 (Mutualistic)")
pos9_1 <- cbind(subset(first_try, interval==".9_1"), Interaction_Rate="0.6 to 1.0 (Mutualistic)")
pos1 <- cbind(subset(first_try, interval=="1"), Interaction_Rate="0.6 to 1.0 (Mutualistic)")

neg1_8 <- cbind(neg1_9, Count = neg1_9$count + neg9_8$count)
neg8_6 <- cbind(neg8_7, Count = neg8_7$count + neg7_6$count)
neg6_4 <- cbind(neg6_5, Count = neg6_5$count + neg5_4$count)
neg4_2 <- cbind(neg4_3, Count = neg4_3$count + neg3_2$count)
neg2_0 <- cbind(neg2_1, Count = neg2_1$count + neg1_0$count)
pos0_2 <- cbind(pos0_1, Count = pos0_1$count + pos1_2$count)
pos2_4 <- cbind(pos2_3, Count = pos2_3$count + pos3_4$count)
pos4_6 <- cbind(pos4_5, Count = pos4_5$count + pos5_6$count)
pos6_8 <- cbind(pos6_7, Count = pos6_7$count + pos7_8$count)
pos8_1 <- cbind(pos8_9, Count = pos8_9$count + pos9_1$count + pos1$count)

combined <- rbind(neg1_8, neg8_6, neg6_4, neg4_2, neg2_0, pos0_2, pos2_4, pos4_6, pos6_8, pos8_1)

vert0 <- cbind(subset(combined, treatment=="mut0.001_mult1_vert0._start0."), Rate = "0%")
vert10 <- cbind(subset(combined, treatment=="mut0.001_mult1_vert0.1_start0."), Rate = "10%")
vert20 <- cbind(subset(combined, treatment=="mut0.001_mult1_vert0.2_start0."), Rate = "20%")
vert30 <- cbind(subset(combined, treatment=="mut0.001_mult1_vert0.3_start0."), Rate = "30%")
vert40 <- cbind(subset(combined, treatment=="mut0.001_mult1_vert0.4_start0."), Rate = "40%")
vert50 <- cbind(subset(combined, treatment=="mut0.001_mult1_vert0.5_start0."), Rate = "50%")
vert60 <- cbind(subset(combined, treatment=="mut0.001_mult1_vert0.6_start0."), Rate = "60%")
vert70 <- cbind(subset(combined, treatment=="mut0.001_mult1_vert0.7_start0."), Rate = "70%")
vert80 <- cbind(subset(combined, treatment=="mut0.001_mult1_vert0.8_start0."), Rate = "80%")
vert90 <- cbind(subset(combined, treatment=="mut0.001_mult1_vert0.9_start0."), Rate = "90%")
vert100 <- cbind(subset(combined, treatment=="mut0.001_mult1_vert1._start0."), Rate = "100%")

combined <- rbind(vert0, vert10, vert20, vert30, vert40, vert50, vert60, vert70, vert80, vert90, vert100)

temp <- aggregate(list(Count = combined$Count), list(update=combined$update, Interaction_Rate=combined$Interaction_Rate, Rate=combined$Rate), mean)

ggplot(temp, aes(update, Count)) + geom_area(aes(fill=Interaction_Rate), position='stack') +ylab("Count of Symbionts with Phenotype") + xlab("Evolutionary time (in updates)") +scale_fill_manual("Interaction Rate\n Phenotypes", values=tenhelix)  + facet_wrap(~Rate)

##Reps
combined <- vert60
temp <- aggregate(list(Count = combined$Count), list(update=combined$update, rep=combined$rep, Interaction_Rate=combined$Interaction_Rate, Rate=combined$Rate), sum)

ggplot(temp, aes(update, Count)) + geom_area(aes(fill=Interaction_Rate), position='stack') +ylab("Count of Hosts with Phenotype") + xlab("Evolutionary time (in updates)") +scale_fill_manual("Interaction Rate\n Phenotypes",values=tenhelix) + theme(panel.background = element_rect(fill='light grey', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + guides(fill=FALSE) + guides(fill = guide_legend())+ facet_wrap(~rep)


##+ facet_wrap(~treatment)

##Hosts
host_data <- read.table("munged_buckets_host.dat", h=T)
first_try <- host_data
first_try <- subset(host_data, update <=50000)
first_try <- subset(host_data, treatment=="mut0.001_mult1_vert0.7_start0.", h=T)
first_try <- subset(first_try, rep=="1003")
first_try <- subset(host_data, update <= 2000)
first_try <- subset(first_try, treatment=="mut0.001_mult1_vert0.5_start0.")

neg1_9 <- cbind(subset(first_try, interval=="-1_-.9"), Interaction_Rate="-1 to -0.8 (Defensive)")
neg9_8 <- cbind(subset(first_try, interval=="-.9_-.8"), Interaction_Rate="-1 to -0.8 (Defensive)")
neg8_7 <- cbind(subset(first_try, interval=="-.8_-.7"), Interaction_Rate="-0.8 to -0.6 (Defensive)")
neg7_6 <- cbind(subset(first_try, interval=="-.7_-.6"), Interaction_Rate="-0.8 to -0.6 (Defensive)")
neg6_5 <- cbind(subset(first_try, interval=="-.6_-.5"), Interaction_Rate="-0.6 to -0.4 (Mildly Defensive)")
neg5_4 <- cbind(subset(first_try, interval=="-.5_-.4"), Interaction_Rate="-0.6 to -0.4 (Mildly Defensive)")
neg4_3 <- cbind(subset(first_try, interval=="-.4_-.3"), Interaction_Rate="-0.4 to -0.2 (Mildly Defensive)")
neg3_2 <- cbind(subset(first_try, interval=="-.3_-.2"), Interaction_Rate="-0.4 to -0.2 (Mildly Defensive)")
neg2_1 <- cbind(subset(first_try, interval=="-.2_-.1"), Interaction_Rate="-0.2 to 0 (Nearly Neutral)")
neg1_0 <- cbind(subset(first_try, interval=="-.1_0"), Interaction_Rate="-0.2 to 0 (Nearly Neutral)")
pos0_1 <- cbind(subset(first_try, interval=="0_.1"), Interaction_Rate="0 to 0.2 (Nearly Neutral)")
pos1_2 <- cbind(subset(first_try, interval==".1_.2"), Interaction_Rate="0 to 0.2 (Nearly Neutral)")
pos2_3 <- cbind(subset(first_try, interval==".2_.3"), Interaction_Rate="0.2 to 0.4 (Positive)")
pos3_4 <- cbind(subset(first_try, interval==".3_.4"), Interaction_Rate="0.2 to 0.4 (Positive)")
pos4_5 <- cbind(subset(first_try, interval==".4_.5"), Interaction_Rate="0.4 to 0.6 (Positive)")
pos5_6 <- cbind(subset(first_try, interval==".5_.6"), Interaction_Rate="0.4 to 0.6 (Positive)")
pos6_7 <- cbind(subset(first_try, interval==".6_.7"), Interaction_Rate="0.6 to 0.8 (Mutualistic)")
pos7_8 <- cbind(subset(first_try, interval==".7_.8"), Interaction_Rate="0.6 to 0.8 (Mutualistic)")
pos8_9 <- cbind(subset(first_try, interval==".8_.9"), Interaction_Rate="0.8 to 1.0 (Mutualistic)")
pos9_1 <- cbind(subset(first_try, interval==".9_1"), Interaction_Rate="0.8 to 1.0 (Mutualistic)")
pos1 <- cbind(subset(first_try, interval=="1"), Interaction_Rate="0.8 to 1.0 (Mutualistic)")

neg1_8 <- cbind(neg1_9, Count = neg1_9$count + neg9_8$count)
neg8_6 <- cbind(neg8_7, Count = neg8_7$count + neg7_6$count)
neg6_4 <- cbind(neg6_5, Count = neg6_5$count + neg5_4$count)
neg4_2 <- cbind(neg4_3, Count = neg4_3$count + neg3_2$count)
neg2_0 <- cbind(neg2_1, Count = neg2_1$count + neg1_0$count)
pos0_2 <- cbind(pos0_1, Count = pos0_1$count + pos1_2$count)
pos2_4 <- cbind(pos2_3, Count = pos2_3$count + pos3_4$count)
pos4_6 <- cbind(pos4_5, Count = pos4_5$count + pos5_6$count)
pos6_8 <- cbind(pos6_7, Count = pos6_7$count + pos7_8$count)
pos8_1 <- cbind(pos8_9, Count = pos8_9$count + pos9_1$count + pos1$count)

combined <- rbind(neg1_8, neg8_6, neg6_4, neg4_2, neg2_0, pos0_2, pos2_4, pos4_6, pos6_8, pos8_1)


temp <- aggregate(list(Count = combined$Count), list(update=combined$update, Interaction_Rate=combined$Interaction_Rate, treatment=combined$treatment), mean)

ggplot(temp, aes(update, Count)) + geom_area(aes(fill=Interaction_Rate), position='stack') +ylab("Count of Hosts with Phenotype") + xlab("Evolutionary time (in updates)") +scale_fill_brewer("Interaction Rate\n Phenotypes", palette="Paired") + facet_wrap(~treatment)

combined <- 

temp <- aggregate(list(Count = combined$Count), list(update=combined$update, Interaction_Rate=combined$Interaction_Rate, treatment=combined$treatment, rep=combined$rep), mean)

ggplot(temp, aes(update, Count)) + geom_area(aes(fill=Interaction_Rate), position='stack') +ylab("Count of Hosts with Phenotype") + xlab("Evolutionary time (in updates)") +scale_fill_brewer("Interaction Rate\n Phenotypes", direction=1, palette="Paired") + guides(fill = guide_legend()) + facet_wrap(~rep)

