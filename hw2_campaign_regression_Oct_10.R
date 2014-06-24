# Regression for General Assembly 
# Oct 9, 2013
# Data: Campaigns - How are they performing since the launch of all these new features?


hw2 <- read.csv(file.choose(), head = TRUE)
hw2[1,]

cor(hw2$num_posts, hw2$num_actions)
cor(hw2$num_posts, hw2$num_auth_posts)
cor(hw2$num_posts, hw2$comment_count)
cor(hw2$num_posts, hw2$num_pers_campaigns)

cor(hw2$num_recruiters, hw2$num_recruited_actions)
cor(hw2$num_recruited_actions, hw2$num_actions)

cor(hw2$follows_count, hw2$num_actions)
cor(hw2$follows_count, hw2$num_recruiters)
cor(hw2$follows_count, hw2$num_pers_campaigns)
cor(hw2$follows_count, hw2$comment_count)

cor(hw2$num_pers_campaigns, hw2$num_actions)
cor(hw2$num_pers_campaigns, hw2$num_recruiters)


cor(hw2$num_posts, hw2$num_actions)
cor(hw2$num_pers_campaigns, hw2$num_actions)
cor(hw2$num_recruiters, hw2$num_actions)
cor(hw2$follows_count, hw2$num_actions)
cor(hw2$num_auth_posts, hw2$num_actions)
cor(hw2$comment_count, hw2$num_actions)




# linearmodel <- lm(num_actions ~ follows_count + num_recruited_actions + num_recruiters + true_num_posts + num_auth_posts + num_pers_campaigns + comment_count, data = hw2)

linearmodel <- lm(num_actions ~ follows_count + as.numeric(num_posts) + as.numeric(num_auth_posts) + num_pers_campaigns + num_recruiters + as.numeric(comment_count), data = hw2)

options("scipen" = 100, "digits"=4)

linearmodel
intercept <- 1.0
summary(linearmodel)
