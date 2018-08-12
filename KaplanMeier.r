library(survival)
mydata=read.csv("KM.csv")
fit =survfit(Surv(mydata$month,mydata$status)~mydata$group)
plot(fit, col=c(1:2), xlab="Time (months)", ylab="Fraction tumor free", main="C57BL/6 mice \n Infection with different virus", lty=c(1,2), lwd=2, font=2, font.lab=2, cex.lab=1.5, cex.main=2, mark.time=TRUE)
legend(2,0.3,legend=c("Wildtype","Mutant"), col=c(1:2), lty=c(1:2))

survdiff(Surv(mydata$month,mydata$status) ~mydata$group, rho=0)

